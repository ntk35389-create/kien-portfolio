# Portfolio Nguyễn Trung Kiên

Website tĩnh (HTML), deploy trên Vercel với Framework Preset `Other`, không cần build.

- `index.html`: trang chủ.
- `404.html`: hiện cho mọi đường dẫn chưa có trang.
- Trang con: thêm file cùng tên với link trong `index.html` vào thư mục gốc, link sẽ tự hết 404:
  `project-forever.html`, `project-ielts.html`, `project-vuonxanh.html`, `project-fitapp.html`, `project-heartwise.html`, `project-kimdong.html`, `project-pcu.html`, `project-thinkiz.html`, `project-vcb.html`, `project-vime.html`.
## Cấu trúc trang (cập nhật)
- `apps.html`, `webapps.html`, `websites.html`: 3 trang danh mục (App / Web App / Website), mỗi trang liệt kê dự án.
- `project-*.html`: trang chi tiết từng dự án (18 trang). Ảnh nằm trong `assets/projects/`.
- Chưa có trang: `project-fitapp.html`, `project-vuonxanh.html`.
- `build-projects.ps1` (8 trang từ Behance) và `build-figma.ps1` (10 trang từ Figma + 3 trang danh mục) dùng để tạo lại các trang; chạy `build-projects.ps1` trước, `build-figma.ps1` sau.