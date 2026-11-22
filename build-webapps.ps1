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
}

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
@media(max-width:700px){.fg-grid{grid-template-columns:1fr;gap:32px}.fg-hero,.fg-item .fg-img{border-radius:12px}}
</style>
'@

foreach ($slug in $apps.Keys) {
  $a = $apps[$slug]; $file = "project-$slug.html"
  $hw = $a.hero.Split('x')
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine('<main class="case"><div class="fg-wrap">')
  [void]$sb.AppendLine(('<div class="fg-hero"><img src="assets/projects/{0}-web.webp" width="{1}" height="{2}" loading="eager" decoding="async" alt="{3}"></div>' -f $slug, $hw[0], $hw[1], $a.title))
  [void]$sb.AppendLine('<h2 class="fg-title">Màn hình thiết kế</h2>')
  [void]$sb.AppendLine('<div class="fg-grid">')
  for ($i = 0; $i -lt $a.caps.Count; $i++) {
    $d = $a.shots[$i].Split('x'); $cap = [System.Net.WebUtility]::HtmlEncode($a.caps[$i])
    [void]$sb.AppendLine(('<figure class="fg-item"><div class="fg-img"><img src="assets/projects/{0}-fg-{1:00}.webp" width="{2}" height="{3}" loading="lazy" decoding="async" alt="{4} — {5}"></div><figcaption><b>{1:00}</b>{5}</figcaption></figure>' -f $slug, ($i + 1), $d[0], $d[1], $a.title, $cap))
  }
  [void]$sb.AppendLine('</div></div></main>')
  $body = $sb.ToString().TrimEnd()
  $t = [IO.File]::ReadAllText("$PWD\$file", [Text.Encoding]::UTF8)
  $t = [regex]::Replace($t, '(?s)<main class="case">.*?</main>', { param($m) $body })
  $t = [regex]::Replace($t, '(?s)<style id="fg">.*?</style>\s*', '')
  $t = $t.Replace('</head>', $css + "`n</head>")
  [IO.File]::WriteAllText("$PWD\$file", $t, $utf8)
  "patched $file ($($a.caps.Count) screens)"
}
