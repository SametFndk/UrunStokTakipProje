using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UrunStokTakip.Models;

namespace UrunStokTakip.Controllers
{
    public class SepetController : Controller
    {
        // GET: Sepet
        StokTakipEntities Db = new StokTakipEntities();
        public ActionResult Index(decimal? Tutar)
        {
            if (User.Identity.IsAuthenticated)
            {
                var kullaniciadi = User.Identity.Name;
                var kullanici = Db.Kullanici.FirstOrDefault(x => x.Email == kullaniciadi);
                var model = Db.Sepet.Where(x => x.KullaniciId == kullanici.Id).ToList();
                var idk = Db.Sepet.FirstOrDefault(x => x.KullaniciId == kullanici.Id);
                if (model != null)
                {
                    if (idk == null)
                    {
                        ViewBag.Tutar = "Sepetinizde ürün bulunmamaktadır.";
                    }
                    else if (idk != null)
                    {
                        Tutar = Db.Sepet.Where(x => x.KullaniciId == idk.KullaniciId).Sum(x => x.Urun.Fiyat * x.Adet);
                        ViewBag.Tutar = "Toplam Tutar =" + Tutar + "TL";

                    }
                    return View(model);
                }
            }
            return HttpNotFound();
        }
        public ActionResult SepeteEkle(int id)
        {
            if (User.Identity.IsAuthenticated)
            {
                var kullaniciadi = User.Identity.Name;
                var model = Db.Kullanici.FirstOrDefault(x => x.Email == kullaniciadi);
                var u = Db.Urun.Find(id);
                var sepet = Db.Sepet.FirstOrDefault(x => x.KullaniciId == model.Id && x.UrunId == id);
                if (model != null)
                {
                    if (sepet != null)
                    {
                        sepet.Adet++;
                        sepet.Fiyat = u.Fiyat * sepet.Adet;
                        Db.SaveChanges();
                        return RedirectToAction("Index");
                    }
                    var s = new Sepet
                    {
                        KullaniciId = model.Id,
                        UrunId = u.Id,
                        Adet = 1,
                        Fiyat = u.Fiyat,
                        Tarih = DateTime.Now
                    };
                    Db.Sepet.Add(s);
                    Db.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View();
            }
            return HttpNotFound();
        }

        public ActionResult SepetCount(int? count)
        {
            if (User.Identity.IsAuthenticated)
            {
                var model = Db.Kullanici.FirstOrDefault(x => x.Email == User.Identity.Name);
                count = Db.Sepet.Where(x => x.KullaniciId == model.Id).Count();
                ViewBag.Count = count;
                if (count == 0)
                {
                    ViewBag.count = "";
                }
                return PartialView();
            }
            return HttpNotFound();
        }
        public ActionResult Arttir(int id)
        {
            var model = Db.Sepet.Find(id);
            model.Adet++;
            model.Fiyat = model.Fiyat * model.Adet;
            Db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult Azalt(int id)
        {
            var model = Db.Sepet.Find(id);
            if (model.Adet == 1)
            {
                Db.Sepet.Remove(model);
                Db.SaveChanges();
            }
            model.Adet--;
            model.Fiyat = model.Fiyat * model.Adet;
            Db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult Sil(int id)
        {
            var sil = Db.Sepet.Find(id);
            Db.Sepet.Remove(sil);
            Db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult HepsiniSil()
        {
            if (User.Identity.IsAuthenticated)
            {
                var kullaniciadi = User.Identity.Name;
                var model = Db.Kullanici.FirstOrDefault(x => x.Email == kullaniciadi);
                var sil = Db.Sepet.Where(x => x.KullaniciId == model.Id);
                Db.Sepet.RemoveRange(sil);
                Db.SaveChanges();
                return RedirectToAction("Index");
            }
            return HttpNotFound();    
        }
    }
}