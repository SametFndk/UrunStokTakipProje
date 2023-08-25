using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using UrunStokTakip.Models;

namespace UrunStokTakip.Controllers
{
    public class UrunController : Controller
    {
        // GET: Urun
        StokTakipEntities Db = new StokTakipEntities();
        [Authorize]
        public ActionResult Index(string ara)
        {
            var list = Db.Urun.ToList();
            if (!string.IsNullOrEmpty(ara))
            {
                list=list.Where(x => x.Ad.Contains(ara) || x.Aciklama.Contains(ara)).ToList();
            }
            return View(list);
        }
        [Authorize (Roles ="A")]
        public ActionResult Ekle()
        {
            List<SelectListItem> deger1 = (from x in Db.Kategori.ToList() 
            select new SelectListItem
            {
                Text=x.Ad,
                Value=x.Id.ToString()
            }).ToList();
            
            ViewBag.ktgr = deger1;
            return View();
        }
        [Authorize(Roles = "A")]
        [HttpPost]
        public ActionResult Ekle(Urun Data, HttpPostedFileBase File)
        {
            string path = Path.Combine("~/Content/Image" + File.FileName);
            File.SaveAs(Server.MapPath(path));
            Data.Resim = File.FileName.ToString();
            Db.Urun.Add(Data);
            Db.SaveChanges();
            return RedirectToAction("Index");
        }
        [Authorize(Roles = "A")]
        public ActionResult Sil(int id)
        {
            var urun = Db.Urun.Where(x => x.Id == id).FirstOrDefault();
            Db.Urun.Remove(urun);
            Db.SaveChanges();
            return RedirectToAction("Index");
        }
        [Authorize(Roles = "A")]
        public ActionResult Guncelle(int id)
        {
            var guncelle= Db.Urun.Where(x=>x.Id == id).FirstOrDefault();
            List<SelectListItem> deger1 = (from x in Db.Kategori.ToList()
                                           select new SelectListItem
                                           {
                                               Text = x.Ad,
                                               Value = x.Id.ToString()
                                           }).ToList();

            ViewBag.ktgr = deger1;
            return View(guncelle);
        }
        [Authorize(Roles = "A")]
        [HttpPost]
        public ActionResult Guncelle(Urun model, HttpPostedFileBase File)
        {
            var urun = Db.Urun.Find(model.Id);
            if (File==null)
            { 
            urun.Ad = model.Ad;
            urun.Aciklama = model.Aciklama;
            urun.Fiyat = model.Fiyat;
            urun.Stok = model.Stok;
            urun.Populer = model.Populer;
            urun.KategoriId = model.KategoriId;
            Db.SaveChanges();
            return RedirectToAction("Index");
            }
            else
            {
                urun.Resim = File.FileName.ToString();
                urun.Ad = model.Ad;
                urun.Aciklama = model.Aciklama;
                urun.Fiyat = model.Fiyat;
                urun.Stok = model.Stok;
                urun.Populer = model.Populer;
                urun.KategoriId = model.KategoriId;
                Db.SaveChanges();
                return RedirectToAction("Index");
            }
           
        }
        [Authorize(Roles = "A")]
        public ActionResult KritikStok()
        {
            var kritik=Db.Urun.Where(x=>x.Stok <= 50).ToList();
            return View(kritik);
        }
        public PartialViewResult StokCount()
        {
            if (User.Identity.IsAuthenticated)
            {
                var count = Db.Urun.Where(x => x.Stok < 50).Count();
                ViewBag.count = count;
                var azalan = Db.Urun.Where(x => x.Stok == 50).Count();
                ViewBag.azalan = azalan;
            }
            return PartialView();
        }
        public ActionResult StokGrafik()
        {
           ArrayList deger1 = new ArrayList();
            ArrayList deger2 = new ArrayList();
            var veriler = Db.Urun.ToList();
            veriler.ToList().ForEach(x => deger1.Add(x.Ad));
            veriler.ToList().ForEach(x => deger2.Add(x.Stok));
            var grafik = new Chart(width: 500, height: 500).AddTitle("Ürün-Stok Grafiği").AddSeries(chartType: "Column", name: "Ad", xValue: deger1, yValues: deger2);
            return File(grafik.ToWebImage().GetBytes(),"image/jpeg");
        }
    }
}