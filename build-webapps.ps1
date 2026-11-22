# Rebuilds the case-study body of the 5 web-app project pages: big hero thumbnail + captioned screen grid.
# Run AFTER build-projects.ps1 and build-figma.ps1 (they regenerate the pages this script patches).
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)

$apps = [ordered]@{
  'vime' = @{ hero='1732x1155'; title='VIME x TechPro'
    shots=@('1024x577','1024x577','1024x577','1024x577','1024x577','1024x577','1024x577','1024x577','1024x577','1024x577','1024x577','1024x577')
    caps=@('Đăng nhập','Quản lý chung','Danh sách đăng ký lịch họp','Phiếu đăng ký lịch họp','Kiểm tra phiếu theo từng bước','Lịch họp theo tuần','Chi tiết phòng họp','Cuộc họp trực tuyến · Nội dung','Cuộc họp trực tuyến · Task công việc','Thêm phòng họp mới','Báo cáo · Khung giờ sử dụng','Báo cáo · Yêu cầu hỗ trợ') }
  'pcu' = @{ hero='1732x1155'; title='PCU x TDI Group'
    shots=@('1024x566','1024x566','1024x566','1024x576','1024x576','1024x576','1024x576','1024x576','1024x708','1024x696')
    caps=@('Chi tiết dự án','Chi tiết đơn hàng · Tiến trình phê duyệt','Chi tiết vật tư','Danh sách nhà cung cấp','Tạo đơn hàng từ báo giá','So sánh báo giá','Yêu cầu thanh toán','Phê duyệt vật tư','Cấu hình · Phân quyền vai trò','Lịch sử giá theo nhà cung cấp') }
  'thinkiz' = @{ hero='1732x1155'; title='Thinkiz x Effi AI'
    shots=@('974x548','974x548','974x548','1024x807','1024x803','883x1024','707x1024')
    caps=@('Trang chủ · Khám phá','Đăng nhập','Trang lỗi 404','Canvas dự án · Giao diện sáng','Canvas dự án · Giao diện tối','Tài khoản · Gói dịch vụ và thanh toán','Tài khoản · Tổng quan sử dụng') }
  'vcb' = @{ hero='1500x1000'; title='Vietcombank TCHM'
    shots=@('1024x724','1024x733','1024x757','1024x757','1024x728','1024x730','1024x728','1024x728')
    caps=@('Chọn phương thức đăng ký Check-in','Danh sách nhận trả phòng','Kế hoạch theo quý','Chương trình xung đột','Quản lý thực đơn','Check-in · Đối chiếu thông tin','Sơ đồ chuẩn bị phòng','Chi tiết khoá lưu trú · Đánh giá') }
  'vbim' = @{ hero='1672x941'; title='VBIM x TDI Group'
    shots=@('1024x729','1024x729','1024x729','1024x729','1024x729','1024x729','1024x729','1024x729','1024x729','1024x729')
    caps=@('Đăng nhập','Trang chủ','Trợ lý trò chuyện','Trang chủ · Thông báo','Tổng quan quản lý','Khoá học gần đây','Chi tiết khoá học','Học phần nhân sự','Quản lý khoá học','Thư viện tài liệu') }
  # Landing page: ảnh cả trang rất dài -> thẻ cắt phần đầu (win), bấm vào để cuộn xem đủ trong khung xem lớn
  # kích thước ảnh của các dự án Landing đọc từ assets/projects/manifest_landing.json (cols=3, manifest=$true)
  'vuonxanh' = @{ title='VuonXanh Connect'; cols=3; manifest=$true
    win=@($true,$false,$true,$true,$true,$true,$true)
    caps=@('Trang chủ','Đăng nhập','Gian hàng đối tác','Danh mục sản phẩm','Chi tiết sản phẩm','Tin tức','Chi tiết tin tức') }
  'ielts' = @{ title='IELTS Lab'; cols=3; manifest=$true
    win=@($true,$true,$true,$true,$true,$true,$true,$true,$true)
    caps=@('Trang chủ','Giới thiệu','Phương pháp học C.C.A.C','Lộ trình và lịch học','Đội ngũ giảng viên','Lịch khai giảng','Chi tiết khoá học','Danh sách bài viết','Chi tiết bài viết') }
  'forever' = @{ title='Forever Young'; cols=3; manifest=$true
    win=@($true,$true,$true)
    caps=@('Trang chủ','Nghệ sĩ','Dịch vụ') }
  'laptop' = @{ title='Laptop'; cols=3; manifest=$true
    win=@($true,$true,$true,$true,$true)
    caps=@('Trang chủ','Danh mục sản phẩm','Chi tiết sản phẩm','Tin tức','Chi tiết bài viết') }
  'noithat' = @{ title='Nội thất'; cols=3; manifest=$true
    win=@($true,$true,$true)
    caps=@('Trang chủ','Danh mục sản phẩm','Chi tiết sản phẩm') }
  'horeca' = @{ title='Horeca VN'; cols=3; manifest=$true
    win=@($true,$true,$true,$true,$true,$true,$true,$true,$true,$true)
    caps=@('Trang chủ','Giới thiệu','Công thức đồ uống','Chi tiết công thức','Nguyên liệu và máy móc','Chi tiết nguyên liệu','Tin tức','Chi tiết tin tức','Đào tạo','Liên hệ') }
  'longgiang' = @{ title='Long Giang'; cols=3; manifest=$true
    win=@($true,$true,$true,$true,$true,$true)
    caps=@('Trang chủ','Dự án','Thông tin chuyên ngành','Hồ sơ năng lực','Tin tức','Chi tiết tin tức') }
}
$landMan = Get-Content "$PSScriptRoot\assets\projects\manifest_landing.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$mobMan = Get-Content "$PSScriptRoot\assets\projects\manifest_mobile.json" -Raw -Encoding UTF8 | ConvertFrom-Json

# Mobile app / game: lưới 4 cột screen điện thoại (phone=$true), ảnh gốc từ manifest_mobile.json
$mobile = [ordered]@{
  'scancalo' = @{ title='Flashcal'; caps=@('Giới thiệu · Theo dõi dinh dưỡng','Giới thiệu · Chụp ảnh món ăn','Giới thiệu · Lối sống lành mạnh','Mức độ vận động','Tốc độ đạt mục tiêu · Chậm và đều','Tốc độ đạt mục tiêu · Vừa phải','Tốc độ đạt mục tiêu · Nhanh','Tốc độ đạt mục tiêu · Tăng cơ','Cân nặng mục tiêu','Bật nhắc nhở','Trang chủ','Phân tích theo ngày','Chỉnh sửa hoạt động','Thêm hoạt động','Kết quả món ăn','Chỉnh dinh dưỡng món ăn','Quét thất bại','Đang phân tích món ăn','Chụp món ăn','Điểm danh hằng ngày','Chi tiết công thức','Công thức','Quét tủ lạnh · Hướng dẫn','Quét tủ lạnh · Đang phân tích','Tủ lạnh AI · Gợi ý công thức','Tủ lạnh AI · Cách hoạt động','Ưu đãi giảm 50%','Gỡ quảng cáo','Mục tiêu nước uống','Dung tích cốc','Chuỗi ngày liên tiếp','Nâng cấp Premium','Cài đặt','Cài đặt thông báo') }
  'kinhnguyet' = @{ title='Flovia'; caps=@('Khởi động','Chọn ngôn ngữ','Giới thiệu · Hiểu cơ thể','Giới thiệu · Theo dõi dễ dàng','Giới thiệu · Sống khỏe mỗi ngày','Hồ sơ','Chỉnh sửa hồ sơ','Trợ lý sức khỏe','Chat với trợ lý AI','Thống kê chu kỳ · Chưa có dữ liệu','Thống kê chu kỳ','Thống kê chu kỳ · Xu hướng','Lịch sử chu kỳ','Chi tiết chu kỳ','Chi tiết chu kỳ · Dự đoán','Phân tích · Chu kỳ dài','Phân tích · Chu kỳ bình thường','Bài viết kiến thức','Danh sách bài viết','Kiến thức sức khỏe','Chi tiết bài viết','Lịch theo tháng','Ghi chú hằng ngày','Trang chủ · Ngày kinh nguyệt','Trang chủ · Ngày thường','Trang chủ · Ngày rụng trứng','Câu hỏi · Tên gọi','Câu hỏi · Tên gọi (đã nhập)','Câu hỏi · Năm sinh','Câu hỏi · Độ dài chu kỳ','Câu hỏi · Số ngày hành kinh','Câu hỏi · Ngày bắt đầu kỳ gần nhất','Bật thông báo') }
  'kinhthanh' = @{ title='Holy Bible'; caps=@('Chọn sách và chương','Kế hoạch đọc','Tiếp tục đọc','Trang chủ','Tốc độ phát','Chi tiết kế hoạch','Chọn câu · Đánh dấu','Chọn câu · Menu thao tác','Chia sẻ câu Kinh Thánh','Thêm ghi chú','Trình phát âm thanh','Đọc Kinh Thánh','Hẹn giờ tắt','Cầu nguyện · Chọn người','Đã lưu dấu trang','Dấu trang · Thông báo','Cầu nguyện · Chọn chủ đề','Sao chép câu','Đọc · Chuyển đến câu','Đọc · Mặc định','Cầu nguyện · Chi tiết','Tìm kiếm','Thư viện · Highlight','Thư viện · Ghi chú','Thư viện · Dấu trang','Thư viện · Vuốt để xóa','Suy niệm hằng ngày','Kết quả tìm kiếm','Nhắc nhở kế hoạch','Sửa ghi chú','Chưa có highlight','Giới thiệu · Lời Chúa mọi nơi','Giới thiệu · Bình an trong cầu nguyện') }
  'wallpaper' = @{ title='Depth Wallpaper'; caps=@('Bộ sưu tập','Danh sách hình nền','Xem trước','Hình nền · Yêu thích','Hình nền · Tất cả','Hình nền · Chưa có yêu thích','Cài đặt','Chọn ngôn ngữ','Giới thiệu 1','Giới thiệu 2','Giới thiệu 3','Studio chỉnh sửa') }
  'print' = @{ title='Print Document'; caps=@('Giới thiệu · In tài liệu dễ dàng','Giới thiệu · In từ mọi nguồn','Xem trước','Trang chủ','Trang chủ · Mẫu có sẵn','Trình quét · Chưa có tài liệu','Trình quét · Chọn nguồn quét','Chỉnh ảnh quét','Quét thẻ ID','Cắt ảnh','Xem trước và chỉnh sửa','Công cụ PDF','Sắp xếp trang','Trích xuất văn bản · Gộp','Trích xuất văn bản · Theo trang','Tách và trích xuất trang','Sắp xếp trang · 10 trang','Tuỳ chọn in','Bố cục ảnh · Mỗi tờ','Bố cục ảnh · Bộ lọc','Thêm chữ vào ảnh','Chữ ký · Thêm chữ ký','Vẽ chữ ký','Kết nối máy in','Hướng dẫn kết nối máy in','Hướng dẫn gửi qua email','Lịch sử in','Chi tiết lần in','Danh bạ in · Danh sách','Danh bạ in · Thẻ','Mẫu · Kế hoạch ngày','In ảnh thẻ','Tách trang · Hoàn tất','Tách PDF · 7 tệp','Ảnh thành PDF') }
  'autogara' = @{ title='AUTO GARA'; caps=@('Giới thiệu · Chào mừng','Giới thiệu · Chẩn đoán OBD','Đăng nhập','Đăng nhập · Đã nhập','Tổng quan','Tạo hồ sơ tiếp nhận xe','Chọn khách hàng','Kết quả chẩn đoán','Phân công thợ sửa chữa','Nghiệm thu hạng mục','Chi tiết báo giá','Danh sách báo giá','Chi tiết phát sinh','Phát sinh · Thông tin khách','Phát sinh · Phương án sửa','Duyệt phương án thành công','Phụ tùng được cấp','Đang xác minh vật tư','Chi tiết phiếu xuất kho','Danh sách phiếu xuất kho','Chi tiết hóa đơn','Biên bản bàn giao','Thanh toán','Mã QR thanh toán','Chi tiết khách hàng','Nhắc lịch bảo dưỡng','Tạo hồ sơ gara','Tạo gara thành công','Hàng hóa','Chi tiết lệnh sửa chữa','Danh sách khách hàng','Thông báo đẩy') }
  'giapha' = @{ title='Tâm Hương'; caps=@('Giới thiệu · Chào mừng','Đăng nhập','Xác minh OTP','Điền thông tin cá nhân','Trang chủ','Trang chủ · Dịch vụ chăm sóc mộ phần','Danh sách gia phả','Tạo gia phả mới','Chọn sơ đồ phả hệ','Cây phả hệ','Thêm thành viên','Thông tin thành viên · Chọn ngày','Thông tin thành viên · Mã mời','Kênh gia đình','Kênh gia đình · Tạo lịch hẹn','Chọn người phụ trách','Lịch giỗ','Chi tiết nghi lễ','Danh sách nghi lễ','Mộ phần · Sơ đồ','Danh sách mộ phần','Thông tin mộ phần','Mộ phần · Gói dịch vụ','Mộ phần · Thân nhân','Đánh giá dịch vụ','Chi tiết dịch vụ · Thắp hương','Dịch vụ chăm sóc mộ','Thanh toán · Chọn ngày','Chi tiết công việc','Công việc · Thắp hương online','Bản đồ','Chi tiết khu vực','Bộ lọc','Thông báo','Hoàn thành công việc') }
  'game2' = @{ title='Color Sort: Streak Puzzle'; caps=@('Màn hình khởi động','Trang chủ','Màn chơi','Hướng dẫn vật phẩm ẩn','Hoàn thành màn','Kho hoa','Đơn đặt hoa') }
  'game3' = @{ title='Tile Bloom'; caps=@('Sưu tập · Hướng dương','Sưu tập · Cúc','Sưu tập · Cẩm tú cầu','Sưu tập · Hoa hồng','Sưu tập · Mẫu đơn','Bộ sưu tập · Trang 1','Bộ sưu tập · Trang 2','Màn chơi','Màn chơi · Siêu khó','Cửa hàng','Cửa hàng · Mua chậu','Cửa hàng · Không đủ xu','Lên cấp','Chi tiết hoa · Tưới nước','Mua thêm ô trồng','Khu vườn · Ô trống','Xác nhận bỏ chậu','Xác nhận bỏ cây','Khu vườn · Trang chủ','Khu vườn · Chọn ô trồng','Hướng dẫn nhân vật Grook','Màn hình khởi động','Mở khóa hoa mới','Thua màn · Khay đầy','Rương thưởng','Chiến thắng','Cây lớn lên') }
}
foreach ($k in $mobile.Keys) { $e = $mobile[$k]; $e.mobile = $true; $e.cols = 5; $apps[$k] = $e }
# Thứ tự hiển thị (số thứ tự 1-based trong danh sách caps): onboarding và trang chủ lên đầu
$mobOrder = @{
  'scancalo'   = @(1,2,3,11) + @(4..10) + @(12..34)
  'kinhnguyet' = @(1,2,3,4,5) + @(27..33) + @(24,25,26) + @(6..23)
  'kinhthanh'  = @(32,33,4,1,2,3) + @(5..31)
  'wallpaper'  = @(9,10,11,1) + @(2..8) + @(12)
  'print'      = @(1,2,4,5,3) + @(6..35)
  'game3'      = @(22,21,19,20,16) + @(1..15) + @(17,18) + @(23..27)
}
# 3 dự án showcase: dùng nguyên frame Figma (xếp dọc, cắt đoạn)
$showcase = [ordered]@{ 'kimdong' = 'Kim Đồng Bookstore'; 'heartwise' = 'HeartWise'; 'fitapp' = 'FitApp' }

$css = @'
<style id="fg">
.fg-wrap{max-width:1400px;margin:0 auto}
.fg-hero{border-radius:20px;overflow:hidden;background:#0D060A;border:1px solid var(--line)}
.fg-title{font-family:var(--mono);font-size:.75rem;letter-spacing:.22em;text-transform:uppercase;color:var(--accent);margin:9vh 0 4vh;display:flex;align-items:center;gap:16px}
.fg-title::before{content:"";width:48px;height:1px;background:var(--accent)}
.fg-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:48px 28px;align-items:start}
.fg-item{margin:0}
.fg-item .fg-img{border-radius:16px;overflow:hidden;background:#0D060A;border:1px solid var(--line)}
.fg-item figcaption{margin-top:14px;font-family:var(--mono);font-size:.78rem;letter-spacing:.06em;color:var(--muted)}
.fg-item figcaption b{color:var(--ink);font-weight:400;margin-right:10px}
.fg-grid.cols3{grid-template-columns:repeat(3,minmax(0,1fr))}
.fg-title.first{margin-top:2vh}
.fg-grid.cols5{grid-template-columns:repeat(5,minmax(0,1fr));gap:36px 18px}
@media(max-width:1200px){.fg-grid.cols5{grid-template-columns:repeat(4,minmax(0,1fr))}}
@media(max-width:900px){.fg-grid.cols5{grid-template-columns:repeat(3,minmax(0,1fr))}}
@media(max-width:560px){.fg-grid.cols5{grid-template-columns:repeat(2,minmax(0,1fr));gap:26px 12px}}
.fg-item .fg-img.ph{aspect-ratio:9/19.5;background:#0D060A}
.fg-item .fg-img.ph img{height:100%;object-fit:cover;object-position:top}
@media(max-width:1100px){.fg-grid.cols4{grid-template-columns:repeat(3,minmax(0,1fr))}}
@media(max-width:800px){.fg-grid.cols4{grid-template-columns:repeat(2,minmax(0,1fr));gap:28px 14px}}
.fg-item .fg-img.win{aspect-ratio:4/5}
.fg-item .fg-img.win img{height:100%;object-fit:cover;object-position:top}
@media(max-width:1000px){.fg-grid.cols3{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media(max-width:700px){.fg-grid.cols3{grid-template-columns:1fr}}
.fg-item .fg-img{cursor:zoom-in;transition:transform .35s,border-color .35s}
.fg-item:hover .fg-img{transform:translateY(-4px);border-color:var(--accent)}
.fg-item .fg-img:focus-visible{outline:2px solid var(--accent);outline-offset:3px}
.lb{position:fixed;inset:0;z-index:1000;display:none;align-items:center;justify-content:center;padding:3vh 3vw;background:rgba(8,4,6,.82);backdrop-filter:blur(8px);-webkit-backdrop-filter:blur(8px)}
.lb.open{display:flex}
.lb-box{width:min(1180px,100%);max-height:100%;display:flex;flex-direction:column;background:#150A0F;border:1px solid var(--line);border-radius:18px;padding:18px 18px 16px;box-shadow:0 30px 80px rgba(0,0,0,.55)}
.lb-head{display:flex;align-items:flex-start;justify-content:space-between;gap:16px;margin-bottom:14px}
.lb-name{font-weight:600;font-size:1rem}
.lb-sub{font-family:var(--mono);font-size:.74rem;letter-spacing:.05em;color:var(--muted);margin-top:4px}
.lb-tools{display:flex;align-items:center;gap:8px;flex-shrink:0}
.lb-btn{font-family:var(--mono);font-size:.78rem;color:var(--ink);background:transparent;border:1px solid var(--line);border-radius:10px;padding:8px 13px;cursor:pointer;line-height:1;transition:border-color .25s,color .25s}
.lb-btn:hover{border-color:var(--accent);color:var(--accent)}
.lb-btn:disabled{opacity:.35;cursor:default}
.lb-zoom{min-width:3.4em;text-align:center;font-family:var(--mono);font-size:.78rem;color:var(--muted)}
.lb-stage{flex:1;min-height:0;overflow:auto;border-radius:12px;background:#0D060A;border:1px solid var(--line);cursor:zoom-in;touch-action:pan-x pan-y;overscroll-behavior:contain}
.lb-stage.z{cursor:grab}
.lb-stage.drag{cursor:grabbing;user-select:none}
.lb-stage img{display:block;max-width:none;height:auto;margin:0 auto;-webkit-user-drag:none;user-select:none}
.lb-foot{display:flex;justify-content:space-between;margin-top:14px}
@media(max-width:700px){.lb{padding:0}.lb-box{width:100%;height:100%;border-radius:0;padding:12px}.lb-tools .lb-btn{padding:8px 10px}}
@media(max-width:700px){.fg-grid{grid-template-columns:1fr;gap:32px}.fg-hero,.fg-item .fg-img{border-radius:12px}}
</style>
'@

$modal = @'
<div class="lb" id="lb" role="dialog" aria-modal="true" aria-label="Xem màn hình">
  <div class="lb-box">
    <div class="lb-head">
      <div><div class="lb-name" id="lbName"></div><div class="lb-sub" id="lbSub"></div></div>
      <div class="lb-tools">
        <button class="lb-btn" id="lbOut" aria-label="Thu nhỏ">−</button>
        <span class="lb-zoom" id="lbZoom">100%</span>
        <button class="lb-btn" id="lbIn" aria-label="Phóng to">+</button>
        <button class="lb-btn" id="lbFit" aria-label="Vừa khung">Vừa khung</button>
        <button class="lb-btn" id="lbClose" aria-label="Đóng">✕</button>
      </div>
    </div>
    <div class="lb-stage" id="lbStage"><img id="lbImg" alt=""></div>
    <div class="lb-foot">
      <button class="lb-btn" id="lbPrev">← Trước</button>
      <button class="lb-btn" id="lbNext">Sau →</button>
    </div>
  </div>
</div>
'@

$js = @'
<script id="fgjs">
(function(){
  var items=[].slice.call(document.querySelectorAll('.fg-item')); if(!items.length)return;
  var lb=document.getElementById('lb'),st=document.getElementById('lbStage'),im=document.getElementById('lbImg');
  var nm=document.getElementById('lbName'),sb=document.getElementById('lbSub'),zl=document.getElementById('lbZoom');
  var proj=(document.querySelector('h1')||{}).textContent||'';
  var cur=0,z=1,MAX=4,MIN=1,lastFocus=null,base=0;
  function setZ(nz,cx,cy){
    nz=Math.max(MIN,Math.min(MAX,nz)); if(nz===z)return;
    var r=st.getBoundingClientRect(); cx=cx==null?r.width/2:cx; cy=cy==null?r.height/2:cy;
    var px=(st.scrollLeft+cx)/(im.offsetWidth||1), py=(st.scrollTop+cy)/(im.offsetHeight||1);
    if(!base)base=st.clientWidth-2; z=nz; im.style.width=(base*z)+'px'; st.classList.toggle('z',z>1); zl.textContent=Math.round(z*100)+'%';
    st.scrollLeft=px*im.offsetWidth-cx; st.scrollTop=py*im.offsetHeight-cy;
  }
  function show(i){
    cur=(i+items.length)%items.length; var it=items[cur], src=it.querySelector('img');
    z=1; base=0; im.style.width='100%'; im.onload=function(){base=(im.naturalWidth<800)?Math.min(st.clientWidth-2,im.naturalWidth*1.4):st.clientWidth-2; im.style.width=(base*z)+'px';};
    im.src=src.getAttribute('data-full')||src.currentSrc||src.src; im.alt=src.alt; st.classList.remove('z'); zl.textContent='100%';
    st.scrollTop=0; st.scrollLeft=0;
    nm.textContent=(it.querySelector('figcaption')||{}).textContent.replace(/^\d+/,'');
    sb.textContent=proj+' · '+(cur+1)+' / '+items.length;
  }
  function open(i){ lastFocus=document.activeElement; show(i); lb.classList.add('open'); document.body.style.overflow='hidden'; document.getElementById('lbClose').focus(); }
  function close(){ lb.classList.remove('open'); document.body.style.overflow=''; if(lastFocus&&lastFocus.focus)lastFocus.focus(); }
  items.forEach(function(it,i){
    var box=it.querySelector('.fg-img'); box.setAttribute('role','button'); box.setAttribute('tabindex','0'); box.setAttribute('aria-label','Xem lớn: '+it.querySelector('figcaption').textContent);
    box.addEventListener('click',function(){open(i)});
    box.addEventListener('keydown',function(e){if(e.key==='Enter'||e.key===' '){e.preventDefault();open(i)}});
  });
  document.getElementById('lbClose').onclick=close;
  document.getElementById('lbPrev').onclick=function(){show(cur-1)};
  document.getElementById('lbNext').onclick=function(){show(cur+1)};
  document.getElementById('lbIn').onclick=function(){setZ(z*1.5)};
  document.getElementById('lbOut').onclick=function(){setZ(z/1.5)};
  document.getElementById('lbFit').onclick=function(){setZ(1)};
  lb.addEventListener('click',function(e){if(e.target===lb)close()});
  document.addEventListener('keydown',function(e){
    if(!lb.classList.contains('open'))return;
    if(e.key==='Escape')close(); else if(e.key==='ArrowLeft')show(cur-1); else if(e.key==='ArrowRight')show(cur+1);
    else if(e.key==='+'||e.key==='=')setZ(z*1.5); else if(e.key==='-')setZ(z/1.5); else if(e.key==='0')setZ(1);
  });
  st.addEventListener('wheel',function(e){
    if(!(e.ctrlKey||e.metaKey))return; e.preventDefault();
    var r=st.getBoundingClientRect(); setZ(z*(e.deltaY<0?1.15:1/1.15),e.clientX-r.left,e.clientY-r.top);
  },{passive:false});
  st.addEventListener('dblclick',function(e){var r=st.getBoundingClientRect(); setZ(z>1?1:2.2,e.clientX-r.left,e.clientY-r.top)});
  var pts={},d0=0,z0=1,drag=null;
  st.addEventListener('pointerdown',function(e){
    pts[e.pointerId]=e; var k=Object.keys(pts);
    if(k.length===2){var a=pts[k[0]],b=pts[k[1]]; d0=Math.hypot(a.clientX-b.clientX,a.clientY-b.clientY); z0=z; drag=null;}
    else if(e.pointerType==='mouse'&&z>1){drag={x:e.clientX,y:e.clientY,l:st.scrollLeft,t:st.scrollTop}; st.classList.add('drag'); st.setPointerCapture(e.pointerId);}
  });
  st.addEventListener('pointermove',function(e){
    if(pts[e.pointerId])pts[e.pointerId]=e; var k=Object.keys(pts);
    if(k.length===2&&d0){var a=pts[k[0]],b=pts[k[1]],r=st.getBoundingClientRect(); setZ(z0*Math.hypot(a.clientX-b.clientX,a.clientY-b.clientY)/d0,(a.clientX+b.clientX)/2-r.left,(a.clientY+b.clientY)/2-r.top);}
    else if(drag){st.scrollLeft=drag.l-(e.clientX-drag.x); st.scrollTop=drag.t-(e.clientY-drag.y);}
  });
  function up(e){delete pts[e.pointerId]; if(Object.keys(pts).length<2)d0=0; if(drag){drag=null; st.classList.remove('drag');}}
  st.addEventListener('pointerup',up); st.addEventListener('pointercancel',up);
})();
</script>
'@

foreach ($slug in $apps.Keys) {
  $a = $apps[$slug]; $file = "project-$slug.html"
  if ($a.mobile) { $mh = $mobMan.$slug.hero; $hw = @([string]$mh.w, [string]$mh.h) } elseif ($a.manifest) { $lm = $landMan.$slug; $hw = @([string]$lm.hero[0], [string]$lm.hero[1]) } else { $hw = $a.hero.Split('x') }
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine('<main class="case"><div class="fg-wrap">')
  $heroSrc = if ($a.mobile) { "assets/projects/$($mobMan.$slug.hero.f)" } elseif ($a.cols -eq 3) { "assets/projects/$slug-web2.webp" } else { "assets/projects/$slug-web.webp" }
  if (-not $a.mobile) { [void]$sb.AppendLine(('<div class="fg-hero"><img src="{0}" width="{1}" height="{2}" loading="eager" decoding="async" alt="{3}"></div>' -f $heroSrc, $hw[0], $hw[1], $a.title)) }
  [void]$sb.AppendLine($(if ($a.mobile) { '<h2 class="fg-title first">Màn hình thiết kế</h2>' } else { '<h2 class="fg-title">Màn hình thiết kế</h2>' }))
  $gcls = if ($a.mobile) { 'fg-grid cols5' } elseif ($a.cols -eq 3) { 'fg-grid cols3' } else { 'fg-grid' }
  [void]$sb.AppendLine("<div class=`"$gcls`">")
  $seq = if ($a.mobile -and $mobOrder.Contains($slug)) { @($mobOrder[$slug] | ForEach-Object { $_ - 1 }) } else { @(0..($a.caps.Count - 1)) }
  $pos = 0
  foreach ($i in $seq) {
    $pos++
    $cap = [System.Net.WebUtility]::HtmlEncode($a.caps[$i])
    $wcls = if ($a.mobile) { 'fg-img ph' } elseif ($a.win -and $a.win[$i]) { 'fg-img win' } else { 'fg-img' }
    if ($a.mobile) {
      $s = $mobMan.$slug.shots[$i]
      [void]$sb.AppendLine(('<figure class="fg-item"><div class="' + $wcls + '"><img src="assets/projects/{0}" width="{1}" height="{2}" loading="lazy" decoding="async" alt="{3} — {4}"></div><figcaption><b>{5:00}</b>{4}</figcaption></figure>' -f $s.f, $s.w, $s.h, $a.title, $cap, $pos))
    } elseif ($a.manifest) {
      $s = $lm.shots[$i]
      [void]$sb.AppendLine(('<figure class="fg-item"><div class="' + $wcls + '"><img src="assets/projects/{0}" data-full="assets/projects/{1}" width="{2}" height="{3}" loading="lazy" decoding="async" alt="{4} — {5}"></div><figcaption><b>{6:00}</b>{5}</figcaption></figure>' -f $s.t, $s.f, $s.tw, $s.th, $a.title, $cap, ($i + 1)))
    } else {
      $d = $a.shots[$i].Split('x')
      [void]$sb.AppendLine(('<figure class="fg-item"><div class="' + $wcls + '"><img src="assets/projects/{0}-fg-{1:00}.webp" width="{2}" height="{3}" loading="lazy" decoding="async" alt="{4} — {5}"></div><figcaption><b>{1:00}</b>{5}</figcaption></figure>' -f $slug, ($i + 1), $d[0], $d[1], $a.title, $cap))
    }
  }
  [void]$sb.AppendLine('</div></div></main>')
  $body = $sb.ToString().TrimEnd()
  $t = [IO.File]::ReadAllText("$PWD\$file", [Text.Encoding]::UTF8)
  $t = [regex]::Replace($t, '(?s)<main class="case">.*?</main>', { param($m) $body })
  $t = [regex]::Replace($t, '(?s)<style id="fg">.*?</style>\s*', '')
  $t = $t.Replace('</head>', $css + "`n</head>")
  $t = [regex]::Replace($t, '(?s)<!--lb-->.*?<!--/lb-->\s*', '')
  $t = [regex]::Replace($t, '(?s)<script id="fgjs">.*?</script>\s*', '')
  $t = $t.Replace('</body>', "<!--lb-->`n" + $modal + "`n<!--/lb-->`n" + $js + "`n</body>")
  [IO.File]::WriteAllText("$PWD\$file", $t, $utf8)
  "patched $file ($($a.caps.Count) screens)"
}

# ---- 3 dự án showcase (Kim Đồng, HeartWise, FitApp): nguyên frame Figma, xếp dọc theo từng đoạn ----
foreach ($slug in $showcase.Keys) {
  $file = "project-$slug.html"; $chunks = $mobMan.$slug.chunks
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine('<main class="case"><div class="case-inner">')
  for ($i = 0; $i -lt $chunks.Count; $i++) {
    $c = $chunks[$i]; $ld = if ($i -eq 0) { 'eager' } else { 'lazy' }
    [void]$sb.AppendLine(('<img src="assets/projects/{0}" width="{1}" height="{2}" loading="{3}" decoding="async" alt="{4} — phần {5}">' -f $c.f, $c.w, $c.h, $ld, $showcase[$slug], ($i + 1)))
  }
  [void]$sb.AppendLine('</div></main>')
  $body = $sb.ToString().TrimEnd()
  $t = [IO.File]::ReadAllText("$PWD\$file", [Text.Encoding]::UTF8)
  $t = [regex]::Replace($t, '(?s)<main class="case">.*?</main>', { param($m) $body })
  [IO.File]::WriteAllText("$PWD\$file", $t, $utf8)
  "patched $file ($($chunks.Count) frame parts)"
}