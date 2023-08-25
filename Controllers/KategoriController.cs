using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UrunStokTakip.Models;

namespace UrunStokTakip.Controllers
{
    public class KategoriController : Controller
    {
        // GET: Kategori
        StokTakipEntities Db = new StokTakipEntities();
        [Authorize(Roles = "A")]
        public ActionResult Index()
        {
            return View(Db.Kategori.Where(x => x.Durum==true).ToList());
        }
        [Authorize(Roles = "A")]
        public ActionResult Ekle()
        {
            return View();
        }
        [HttpPost]
        [Authorize(Roles = "A")]
        public ActionResult Ekle(Kategori data)
        {
            Db.Kategori.Add(data);
            data.Durum = true;
            Db.SaveChanges();
            return RedirectToAction("Index");
        }
        [Authorize(Roles = "A")]
        public ActionResult Sil(int id)
        {
            var kategori = Db.Kategori.Where(x => x.Id == id).FirstOrDefault();
            Db.Kategori.Remove(kategori);
            kategori.Durum = false;
            Db.SaveChanges();
            return RedirectToAction("Index");
        }
        [Authorize(Roles = "A")]
        public ActionResult Guncelle(Kategori data)
        {
            var guncelle = Db.Kategori.Where(x => x.Id == data.Id).FirstOrDefault();
            guncelle.Aciklama = data.Aciklama;
            guncelle.Ad = data.Ad;
            Db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}