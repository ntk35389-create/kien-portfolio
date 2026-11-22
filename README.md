# Portfolio Nguyễn Trung Kiên

Website tĩnh (HTML), deploy trên Vercel với Framework Preset `Other`, không cần build.

- `index.html`: trang chủ.
- `404.html`: hiện cho mọi đường dẫn chưa có trang.
- Trang con: thêm file cùng tên với link trong `index.html` vào thư mục gốc, link sẽ tự hết 404:
  `project-forever.html`, `project-ielts.html`, `project-vuonxanh.html`, `project-fitapp.html`, `project-heartwise.html`, `project-kimdong.html`, `project-pcu.html`, `project-thinkiz.html`, `project-vcb.html`, `project-vime.html`.
## Cấu trúc trang (cập nhật)
- `apps.html`, `webapps.html`, `websites.html`: 3 trang danh mục (App / Web App / Website), mỗi trang liệt kê dự án.
- `project-*.html`: trang chi tiết từng dự án (18 trang). Ảnh nằm trong `assets/projects/`.
- Tất cả thẻ trên trang chủ đều đã có trang chi tiết.
- `build-projects.ps1` (8 trang từ Behance) và `build-figma.ps1` (10 trang từ Figma + 3 trang danh mục) dùng để tạo lại các trang; chạy `build-projects.ps1` trước, `build-figma.ps1` sau.

- Web App và Landing Page (vime, pcu, thinkiz, vcb, vbim, vuonxanh, ielts, forever, laptop, noithat, horeca, longgiang): sau khi chạy uild-projects.ps1 và uild-figma.ps1, chạy thêm uild-webapps.ps1 để dựng lại thân trang (thumb lớn + lưới màn hình có chú thích, ảnh *-web.webp và *-fg-NN.webp).
- Ảnh Landing Page: màn hình xuất từ Figma ở độ phân giải gốc (ssets/projects/<slug>-fg-NN.webp, dùng cho khung xem to) và bản cắt đầu trang (<slug>-fgt-NN.webp, dùng cho lưới); kích thước ghi trong ssets/projects/manifest_landing.json.
- Mobile: chạy thêm uild-webapps.ps1 (sau build-projects và build-figma) để dựng lưới screen có chú thích và khung xem to; ảnh screen xuất từ Figma ở độ phân giải gốc (<slug>-m-NN.webp), 3 dự án showcase (Kim Đồng, HeartWise, FitApp) dùng nguyên frame Figma cắt đoạn (<slug>-sc-NN.webp). Kích thước ghi trong ssets/projects/manifest_mobile.json.
