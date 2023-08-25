using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UrunStokTakip.Models;
using PagedList;
using PagedList.Mvc;
using System.Web.UI.WebControls;

namespace UrunStokTakip.Controllers
{
    public class SatisController : Controller
    {
        // GET: Satis
        StokTakipEntities Db = new StokTakipEntities();
        public ActionResult Index(int sayfa = 1)
        {
            if (User.Identity.IsAuthenticated)
            {
                var kullaniciadi = User.Identity.Name;
                var kullanici = Db.Kullanici.FirstOrDefault(x => x.Email == kullaniciadi);
                var model = Db.Satislar.Where(x => x.KullaniciId == kullanici.Id).ToList().ToPagedList(sayfa, 5);
                return View(model);
            }
            return HttpNotFound();
        }
        public ActionResult SatinAl(int id)
        {
            var model = Db.Sepet.FirstOrDefault(x => x.Id == id);
            return View(model);
        }

        [HttpPost]
        public ActionResult SatinAl2(int id)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var model = Db.Sepet.FirstOrDefault(x => x.Id == id);

                    var satis = new Satislar
                    {
                        KullaniciId = model.KullaniciId,
                        UrunId = model.UrunId,
                        Adet = model.Adet,
                        Resim = model.Resim,
                        Fiyat = model.Fiyat,
                        Tarih = model.Tarih,
                    };
                    Db.Sepet.Remove(model);
                    Db.Satislar.Add(satis);
                    Db.SaveChanges();
                    ViewBag.islem = "Satın alma işlemi başarıyla gerçekleştirildi";

                }
            }
            catch (Exception)
            {

                ViewBag.islem = "Satın alma işlemi başarısız";
            }
            return View("islem");
        }
        public ActionResult HepsiniSatinAl(decimal? Tutar)
        {
            if (User.Identity.IsAuthenticated)
            {
                var kullaniciadi = User.Identity.Name;
                var kullanici = Db.Kullanici.FirstOrDefault(x => x.Email == kullaniciadi);
                var model = Db.Sepet.Where(x => x.KullaniciId == kullanici.Id).ToList();
                var idk = Db.Sepet.FirstOrDefault(x => x.KullaniciId == kullanici.Id);
                if (model != null)
                {
                    if (idk != null)
                    {
                        ViewBag.Tutar = "Sepetinizde ürün bulunmamaktadır";
                    }
                    else if (idk != null)
                    {
                        Tutar = Db.Sepet.Where(x => x.KullaniciId == kullanici.Id).Sum(x => x.Urun.Fiyat * x.Adet);
                        ViewBag.Tutar = "Toplam Tutar = " + Tutar + "TL";
                    }
                    return View(model);
                }
                return View();
            }
            return HttpNotFound();
        }
        [HttpPost]
        public ActionResult HepsiniSatinAl2()
        {
            var username = User.Identity.Name;
            var kullanici = Db.Kullanici.FirstOrDefault(x => x.Email == username);
            var model = Db.Sepet.Where(x => x.KullaniciId == kullanici.Id).ToList();
            int satir = 0;
            foreach (var item in model)
            {
                var satis = new Satislar
                {
                    KullaniciId = model[satir].KullaniciId,
                    UrunId = model[satir].UrunId,
                    Adet = model[satir].Adet,
                    Fiyat = model[satir].Fiyat,
                    Resim = model[satir].Urun.Resim,
                    Tarih = DateTime.Now

                };
                Db.Satislar.Add(satis);
                Db.SaveChanges();
                satir++;
            }
            Db.Sepet.RemoveRange(model);
            Db.SaveChanges();
            return RedirectToAction("Index", "Sepet");
        }
    }
}