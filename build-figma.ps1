# Tạo các trang dự án lấy từ Figma + 3 trang danh mục (apps / webapps / websites).
# Chạy: powershell -File build-figma.ps1   (cần assets/projects/manifest_figma.json)
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$fm = Get-Content "$root\assets\projects\manifest_figma.json" -Raw -Encoding UTF8 | ConvertFrom-Json
function Esc($s) { [System.Net.WebUtility]::HtmlEncode($s) }
$utf8 = New-Object Text.UTF8Encoding($false)

# ---------- dữ liệu ----------
# source: 'figma' (có trong manifest_figma.json) hoặc 'behance' (trang đã có từ build-projects.ps1)
$PRJ = [ordered]@{}
function Add-P($slug, $h) { $h.slug = $slug; $PRJ[$slug] = $h }

# --- App ---
Add-P 'kimdong'   @{ source='behance'; cover='kimdong-thumb.webp'; cat='apps'; title='Kim Đồng Bookstore'; tag='Redesign · Mobile App'; color='#E8485E'; desc='Thiết kế lại trải nghiệm ứng dụng nhà sách Kim Đồng: điều hướng, gợi ý cá nhân hóa và hệ thống giao diện mới cho phụ huynh và bạn đọc nhỏ tuổi.' }
Add-P 'heartwise' @{ source='behance'; cover='heartwise-thumb.webp'; cat='apps'; title='HeartWise'; tag='Habit Building · Gamification'; color='#4CC76A'; desc='Ứng dụng xây dựng thói quen ăn uống và vận động để phòng ngừa bệnh tim, giữ động lực mỗi ngày qua tương tác dạng trò chơi.' }
Add-P 'scancalo'  @{ source='figma'; cover='scancalo-thumb-v2.webp'; cat='apps'; title='Scan Calo'; tag='Health & Nutrition · Mobile App'; color='#FF8A1F'; platform='Mobile App (iOS / Android)'; kind='Ứng dụng quét món ăn và theo dõi calo';
  desc='Ứng dụng theo dõi dinh dưỡng và calo: quét món ăn bằng camera, thêm hoạt động, check-in hằng ngày, công thức nấu ăn, tủ lạnh, chuỗi streak, mục tiêu uống nước và gói trả phí trong ứng dụng.'; tags=@('Mobile App','User flow','Health') }
Add-P 'kinhnguyet' @{ source='figma'; cover='kinhnguyet-mock.webp'; cat='apps'; title='Kinh nguyệt'; tag='Women''s Health · Mobile App'; color='#FF6B8B'; platform='Mobile App'; kind='Ứng dụng theo dõi chu kỳ';
  desc='Ứng dụng theo dõi chu kỳ kinh nguyệt: onboarding, trang chủ dạng lịch, phân tích chu kỳ, ghi chú hằng ngày, trò chuyện với trợ lý AI và các thiết lập cá nhân.'; tags=@('Mobile App','Lịch','AI chat') }
Add-P 'kinhthanh' @{ source='figma'; cover='kinhthanh-mock4.webp'; cat='apps'; title='Kinh Thánh'; tag='Lifestyle · Mobile App'; color='#C9A66B'; platform='Mobile App'; kind='Ứng dụng đọc và cầu nguyện';
  desc='Ứng dụng đồng hành đời sống tâm linh: onboarding, trang chủ, kế hoạch đọc, bài quiz, lời cầu nguyện cá nhân hóa và trang hồ sơ.'; tags=@('Mobile App','Onboarding','Cá nhân hóa') }
Add-P 'wallpaper' @{ source='figma'; cover='wallpaper-mock4.webp'; cat='apps'; title='Wallpaper'; tag='Personalization · Mobile App'; color='#8B7CFF'; platform='Mobile App'; kind='Ứng dụng hình nền';
  desc='Ứng dụng hình nền: duyệt kho hình, bộ sưu tập, studio chỉnh sửa với hiệu ứng chiều sâu, đổi font đồng hồ và các thiết lập.'; tags=@('Mobile App','Studio','Personalization') }
Add-P 'print'     @{ source='figma'; cover='print-mock4.webp'; cat='apps'; title='Print Document'; tag='Utility · Mobile App'; color='#3A7BFF'; platform='Mobile App'; kind='Ứng dụng in tài liệu';
  desc='Ứng dụng in tài liệu từ điện thoại: hướng dẫn kết nối máy in qua Wi-Fi, in tài liệu, ảnh, trang web và email, bộ công cụ PDF và Print Studio.'; tags=@('Mobile App','Utility','PDF') }
Add-P 'autogara'  @{ source='figma'; cover='autogara-mock4.webp'; cat='apps'; title='AUTO GARA'; tag='Mobile App · Quản lý gara'; color='#E5484D'; platform='Mobile App (hệ thống quản lý gara)'; kind='Hệ thống quản lý quy trình gara';
  desc='Hệ thống quản lý quy trình gara ô tô: tiếp nhận xe, lệnh sửa chữa, báo giá, phát sinh, phiếu xuất kho, hóa đơn, thanh toán và hồ sơ khách hàng.'; tags=@('Hệ thống','Quy trình','Mobile') }
Add-P 'giapha'    @{ source='figma'; cover='giapha-mock4.webp'; cat='apps'; title='Tâm Hương'; tag='Gia phả · Mobile App'; color='#C8963E'; platform='App di động và trang quản lý web'; kind='App gia phả kết hợp dịch vụ mộ phần';
  desc='Ứng dụng gia phả kết hợp dịch vụ mộ phần: cây phả hệ, kênh gia đình, lịch giỗ, bản đồ và thông tin mộ phần, gói dịch vụ, trò chuyện chung, cùng trang quản lý dành cho đơn vị cung cấp dịch vụ.'; tags=@('Mobile App','Gia phả','Dịch vụ') }
Add-P 'game2'     @{ source='figma'; cover='game2-mock.webp'; cat='apps'; title='Game 2'; tag='Mobile Game · UI/UX'; color='#4CC76A'; platform='Mobile Game'; kind='Thiết kế UI/UX game';
  desc='Thiết kế giao diện game di động: đặt hàng, level khó, hướng dẫn vật phẩm ẩn, hiệu ứng nhận thưởng, kho đồ và bộ phần tử giao diện.'; tags=@('Game','Mobile','UI kit') }
Add-P 'game3'     @{ source='figma'; cover='game3-mock.webp'; cat='apps'; title='Game 3'; tag='Mobile Game · UI/UX'; color='#FF7A59'; platform='Mobile Game (điện thoại và iPad)'; kind='Thiết kế UI/UX game';
  desc='Thiết kế giao diện game di động: trạng thái tương tác ở màn hình chính, gameplay, hướng dẫn đầu game, bộ sưu tập, cửa hàng, hiệu ứng trợ giúp và màn kết thúc.'; tags=@('Game','Mobile','Tutorial') }

# --- Web App ---
Add-P 'vime'      @{ source='behance'; cat='webapps'; title='VIME × TechPro'; tag='Web App · Dashboard'; color='#8B7CFF'; desc='Nền tảng quản lý phòng họp và lịch họp cho doanh nghiệp: đặt phòng, phê duyệt, check-in và báo cáo hiệu suất sử dụng.' }
Add-P 'vcb'       @{ source='behance'; cat='webapps'; title='Vietcombank TCHM'; tag='Web App · Quản lý nội bộ'; color='#3DBC8D'; desc='Hệ thống quản lý lưu trú cho cán bộ nhân viên Vietcombank: check-in, sơ đồ phòng, kế hoạch theo quý và đánh giá dịch vụ.' }
Add-P 'pcu'       @{ source='behance'; cat='webapps'; title='PCU × TDI Group'; tag='Web App · Enterprise'; color='#FF5C5C'; desc='Số hóa quy trình khối cung ứng: yêu cầu mua sắm, so sánh báo giá, phê duyệt vật tư, quản lý nhà cung cấp và tồn kho.' }
Add-P 'vbim'      @{ source='figma'; cat='webapps'; title='VBIM × TDI Group'; tag='Web App · E-learning'; color='#2F6BFF'; platform='Web App (desktop)'; kind='Nền tảng học tập trực tuyến';
  desc='Nền tảng học tập trực tuyến: đăng nhập, trang chủ có trợ lý trò chuyện, danh sách và chi tiết khóa học, bài học kèm bài kiểm tra cuối khóa, kho cá nhân để lưu video và thư viện tài liệu.'; tags=@('Web App','E-learning','Dashboard') }
Add-P 'thinkiz'   @{ source='behance'; cat='webapps'; title='Thinkiz × Effi AI'; tag='Web App · AI Workspace'; color='#5EA8FF'; desc='Agentic workspace cho cộng tác người và AI: canvas dự án nơi các AI agent tự phân rã tác vụ, nghiên cứu và tạo nội dung.' }

# --- Website ---
Add-P 'forever'   @{ source='behance'; cat='websites'; title='Forever Young'; tag='Entertainment · Corporate Site'; color='#FF9EC4'; desc='Website công ty quản lý KOL, ca sĩ và nhạc sĩ hàng đầu Việt Nam, thẩm mỹ neon đen hồng.' }
Add-P 'ielts'     @{ source='behance'; cat='websites'; title='IELTS Lab'; tag='Education · Landing Page'; color='#6FA8FF'; desc='Website trung tâm luyện thi IELTS: phương pháp học, lộ trình khóa học, đội ngũ giảng viên và bảng vàng thành tích.' }

$cats = [ordered]@{
  apps     = @{ title='Mobile App/Game'; ghost='Dự án'; file='apps.html';     lead='Các ứng dụng di động tôi thiết kế: từ nghiên cứu vấn đề, user flow, style guide đến hệ thống giao diện hoàn chỉnh. Bấm vào từng dự án để xem chi tiết.'; anchor='apps' }
  webapps  = @{ title='Web App'; ghost='/ Hệ thống'; file='webapps.html'; lead='Các nền tảng và hệ thống quản trị doanh nghiệp tôi thiết kế. Bấm vào từng dự án để xem các màn hình chính.'; anchor='systems' }
  websites = @{ title='Website'; ghost='/ Landing page'; file='websites.html'; lead='Website giới thiệu doanh nghiệp và dịch vụ. Bấm vào từng dự án để xem toàn bộ thiết kế.'; anchor='webs' }
}

# ---------- CSS dùng chung ----------
$css = @'
:root{--bg:#150A0F;--ink:#FBF2F4;--muted:#9C8B92;--accent:#FF6B81;--line:rgba(251,242,244,.10);--display:'Unbounded',sans-serif;--body:'Be Vietnam Pro',sans-serif;--mono:'Space Mono',monospace}
*{margin:0;padding:0;box-sizing:border-box}
html{scroll-behavior:smooth}
body{background:var(--bg);color:var(--ink);font-family:var(--body);font-weight:300;overflow-x:hidden}
a{color:inherit;text-decoration:none}
img{display:block;width:100%;height:auto}
::selection{background:var(--accent);color:var(--bg)}
.nav{position:fixed;top:0;left:0;right:0;z-index:900;display:flex;align-items:center;justify-content:space-between;padding:24px 5vw;mix-blend-mode:difference}
.nav .logo{font-family:var(--display);font-weight:800;font-size:1.05rem}
.nav .back{font-family:var(--mono);font-size:.78rem;letter-spacing:.12em;text-transform:uppercase}
.nav .back:hover{opacity:.6}
.hero{position:relative;padding:20vh 5vw 8vh;overflow:hidden}
.aura{position:absolute;width:56vmax;height:56vmax;border-radius:50%;filter:blur(130px);opacity:.28;pointer-events:none;background:radial-gradient(circle,var(--accent) 0%,transparent 65%);top:-24vmax;right:-18vmax}
.eyebrow{font-family:var(--mono);font-size:.75rem;letter-spacing:.22em;text-transform:uppercase;color:var(--accent);display:flex;align-items:center;gap:16px;margin-bottom:4vh;position:relative}
.eyebrow::before{content:"";width:48px;height:1px;background:var(--accent)}
h1{font-family:var(--display);font-weight:800;font-size:clamp(2.2rem,8vw,6.8rem);line-height:1;letter-spacing:-.02em;text-transform:uppercase;position:relative}
h1 .ghost{color:transparent;-webkit-text-stroke:1px var(--muted);transition:color .45s,-webkit-text-stroke-color .45s}
h1 .ghost:hover{color:var(--accent);-webkit-text-stroke-color:var(--accent)}
.lead{max-width:640px;font-size:clamp(1rem,1.3vw,1.15rem);line-height:1.75;color:var(--muted);margin-top:5vh;position:relative}
.meta{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:28px;margin-top:7vh;padding-top:4vh;border-top:1px solid var(--line);position:relative}
.meta dt{font-family:var(--mono);font-size:.7rem;letter-spacing:.18em;text-transform:uppercase;color:var(--muted);margin-bottom:8px}
.meta dd{font-weight:500;font-size:1rem}
.tags{display:flex;flex-wrap:wrap;gap:8px}
.tags span{font-family:var(--mono);font-size:.72rem;letter-spacing:.06em;border:1px solid var(--line);border-radius:999px;padding:5px 12px}
.case{padding:2vh 5vw 10vh;max-width:1560px;margin:0 auto}
.shot{margin:0 0 5vh}
.shot figcaption{font-family:var(--mono);font-size:.74rem;letter-spacing:.16em;text-transform:uppercase;color:var(--muted);margin-bottom:14px;display:flex;align-items:center;gap:14px}
.shot figcaption::before{content:"";width:28px;height:1px;background:var(--accent)}
.frame{display:block;border-radius:16px;overflow:hidden;background:#0D060A;border:1px solid var(--line);transition:border-color .3s,transform .3s}
.frame:hover{border-color:var(--accent)}
.phones{display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:22px;align-items:start;margin:0 0 5vh}
.phones .frame{border-radius:22px}
.phones figcaption{margin:10px 2px 0;font-family:var(--mono);font-size:.68rem;letter-spacing:.06em;color:var(--muted)}
.pager{display:grid;grid-template-columns:1fr 1fr;border-top:1px solid var(--line)}
.pager a{padding:7vh 5vw;display:flex;flex-direction:column;gap:12px;transition:background .4s}
.pager a:hover{background:rgba(251,242,244,.04)}
.pager a+a{border-left:1px solid var(--line);text-align:right;align-items:flex-end}
.pager small{font-family:var(--mono);font-size:.72rem;letter-spacing:.18em;text-transform:uppercase;color:var(--muted)}
.pager strong{font-family:var(--display);font-weight:600;font-size:clamp(1.1rem,2.8vw,2.2rem);text-transform:uppercase}
.pager a:hover strong{color:var(--accent)}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(320px,1fr));gap:28px;padding:2vh 5vw 10vh;max-width:1560px;margin:0 auto}
.card{display:flex;flex-direction:column;border:1px solid var(--line);border-radius:20px;overflow:hidden;background:rgba(251,242,244,.02);transition:transform .35s,border-color .35s}
.card:hover{transform:translateY(-6px);border-color:var(--ca)}
.card .media{aspect-ratio:16/10;overflow:hidden;background:#0D060A;position:relative}
.card .media img{width:100%;height:100%;object-fit:cover;object-position:top center;transition:transform .6s}
.card:hover .media img{transform:scale(1.04)}
.card .media.contain{background:color-mix(in srgb,var(--ca) 18%,#0D060A);display:flex;justify-content:center;padding:18px 0 0}
.card .media.contain img{width:auto;height:100%;object-fit:contain;object-position:top center;border-radius:18px 18px 0 0}
.card .body{padding:22px 24px 26px;display:flex;flex-direction:column;gap:10px;flex:1}
.card .tag{font-family:var(--mono);font-size:.7rem;letter-spacing:.16em;text-transform:uppercase;color:var(--ca)}
.card h3{font-family:var(--display);font-weight:600;font-size:1.25rem;text-transform:uppercase;line-height:1.15}
.card p{color:var(--muted);line-height:1.65;font-size:.95rem;flex:1}
.card .cta{font-family:var(--mono);font-size:.76rem;letter-spacing:.12em;text-transform:uppercase;color:var(--ca);margin-top:6px}
.switch{display:flex;flex-wrap:wrap;gap:10px;padding:0 5vw 4vh;position:relative}
.switch a{font-family:var(--mono);font-size:.76rem;letter-spacing:.12em;text-transform:uppercase;border:1px solid var(--line);border-radius:999px;padding:8px 16px}
.switch a:hover,.switch a.on{border-color:var(--accent);color:var(--accent)}
footer{padding:6vh 5vw;border-top:1px solid var(--line);display:flex;flex-wrap:wrap;gap:16px 40px;justify-content:space-between;font-family:var(--mono);font-size:.78rem;letter-spacing:.08em;color:var(--muted)}
footer a:hover{color:var(--accent)}
@media(max-width:700px){.nav .logo{font-size:.9rem}.pager{grid-template-columns:1fr}.pager a+a{border-left:0;border-top:1px solid var(--line);text-align:left;align-items:flex-start}.phones{grid-template-columns:repeat(2,1fr);gap:14px}.grid{grid-template-columns:1fr}}
@media(prefers-reduced-motion:reduce){html{scroll-behavior:auto}.card,.card .media img{transition:none}}
'@

function Head($title, $desc, $color, $ogImg) {
@"
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$(Esc $title) — Nguyễn Trung Kiên, UI/UX Designer</title>
<meta name="description" content="$(Esc $desc)">
<meta property="og:title" content="$(Esc $title) — Nguyễn Trung Kiên">
<meta property="og:description" content="$(Esc $desc)">
<meta property="og:image" content="$ogImg">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Unbounded:wght@300;400;600;800&family=Be+Vietnam+Pro:wght@300;400;500;600&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
<style>
$css
:root{--accent:$color}
</style>
</head>
"@
}

$footer = @'
<footer>
  <span>© Nguyễn Trung Kiên</span>
  <a href="mailto:ntk1510.work@gmail.com">ntk1510.work@gmail.com</a>
  <a href="https://www.behance.net/kiennguyen" target="_blank" rel="noopener">Behance</a>
</footer>
'@

# ---------- trang chi tiết (Figma) ----------
$catOrder = @{}
foreach ($c in $cats.Keys) { $catOrder[$c] = @($PRJ.Keys | Where-Object { $PRJ[$_].cat -eq $c }) }

foreach ($slug in $PRJ.Keys) {
  $p = $PRJ[$slug]
  if ($p.source -ne 'figma') { continue }
  $c = $cats[$p.cat]
  $list = $catOrder[$p.cat]; $i = [array]::IndexOf($list, $slug)
  $prev = $PRJ[$list[($i + $list.Count - 1) % $list.Count]]; $next = $PRJ[$list[($i + 1) % $list.Count]]

  $sb = New-Object Text.StringBuilder
  $items = @($fm.$slug); $k = 0
  while ($k -lt $items.Count) {
    $it = $items[$k]
    if ($it.phone) {
      [void]$sb.AppendLine('<div class="phones">')
      while ($k -lt $items.Count -and $items[$k].phone) {
        $e = $items[$k]
        [void]$sb.AppendLine(('<figure><a class="frame" href="assets/projects/{0}" target="_blank" rel="noopener"><img src="assets/projects/{0}" width="{1}" height="{2}" loading="lazy" decoding="async" alt="{3}"></a><figcaption>{3}</figcaption></figure>' -f $e.f, $e.w, $e.h, (Esc $e.name)))
        $k++
      }
      [void]$sb.AppendLine('</div>')
    } else {
      [void]$sb.AppendLine(('<figure class="shot"><figcaption>{3}</figcaption><a class="frame" href="assets/projects/{0}" target="_blank" rel="noopener"><img src="assets/projects/{0}" width="{1}" height="{2}" loading="{4}" decoding="async" alt="{3}"></a></figure>' -f $it.f, $it.w, $it.h, (Esc $it.name), $(if ($k -eq 0) { 'eager' } else { 'lazy' })))
      $k++
    }
  }
  $tags = ($p.tags | ForEach-Object { '<span>' + (Esc $_) + '</span>' }) -join ''
  $html = (Head $p.title $p.desc $p.color ("assets/projects/" + $items[0].f)) + @"
<body>
<nav class="nav"><a class="logo" href="index.html">KIÊN.</a><a class="back" href="$($c.file)">← $($c.title)</a></nav>
<header class="hero">
  <div class="aura"></div>
  <div class="eyebrow">$(Esc $c.title)</div>
  <h1>$(Esc $p.title)</h1>
  <p class="lead">$(Esc $p.desc)</p>
  <dl class="meta">
    <div><dt>Loại dự án</dt><dd>$(Esc $p.kind)</dd></div>
    <div><dt>Nền tảng</dt><dd>$(Esc $p.platform)</dd></div>
    <div><dt>Vai trò</dt><dd>UI/UX Designer</dd></div>
    <div><dt>Nội dung</dt><dd class="tags">$tags</dd></div>
  </dl>
</header>
<main class="case">
$($sb.ToString())
</main>
<nav class="pager" aria-label="Dự án khác">
  <a href="project-$($prev.slug).html"><small>← Dự án trước</small><strong>$(Esc $prev.title)</strong></a>
  <a href="project-$($next.slug).html"><small>Dự án tiếp →</small><strong>$(Esc $next.title)</strong></a>
</nav>
$footer
</body>
</html>
"@
  [IO.File]::WriteAllText("$root\project-$slug.html", $html, $utf8)
  "wrote project-$slug.html"
}

# Behance pages: sửa nút Dự án trước/tiếp + nav trở về theo danh mục (giữ nội dung)
foreach ($slug in $PRJ.Keys) {
  $p = $PRJ[$slug]; if ($p.source -ne 'behance') { continue }
  $f = "$root\project-$slug.html"; if (-not (Test-Path $f)) { continue }
  $c = $cats[$p.cat]; $list = $catOrder[$p.cat]; $i = [array]::IndexOf($list, $slug)
  $prev = $PRJ[$list[($i + $list.Count - 1) % $list.Count]]; $next = $PRJ[$list[($i + 1) % $list.Count]]
  $t = [IO.File]::ReadAllText($f, [Text.Encoding]::UTF8)
  $t = [regex]::Replace($t, '<a class="back" href="[^"]*">[^<]*</a>', "<a class=`"back`" href=`"$($c.file)`">← $($c.title)</a>")
  $t = [regex]::Replace($t, '<nav class="pager"[\s\S]*?</nav>', @"
<nav class="pager" aria-label="Dự án khác">
  <a href="project-$($prev.slug).html"><small>← Dự án trước</small><strong>$(Esc $prev.title)</strong></a>
  <a href="project-$($next.slug).html"><small>Dự án tiếp →</small><strong>$(Esc $next.title)</strong></a>
</nav>
"@)
  [IO.File]::WriteAllText($f, $t, $utf8)
  "updated nav project-$slug.html"
}

# ---------- trang danh mục ----------
foreach ($ck in $cats.Keys) {
  $c = $cats[$ck]
  $cards = New-Object Text.StringBuilder
  foreach ($slug in $catOrder[$ck]) {
    $p = $PRJ[$slug]
    if ($p.cover) { $img = "assets/projects/" + $p.cover; $contain = $false; $w = 1254; $h = 1254 }
    elseif ($p.source -eq 'behance') { $img = "assets/projects/$slug-1.webp"; $contain = $false; $w = 1400; $h = 1100 }
    else {
      $cov = @($fm.$slug | Where-Object { -not $_.phone })[0]
      if ($cov) { $img = "assets/projects/" + $cov.f; $contain = $false; $w = $cov.w; $h = $cov.h }
      else { $cov = @($fm.$slug)[0]; $img = "assets/projects/" + $cov.f; $contain = $true; $w = $cov.w; $h = $cov.h }
    }
    $mc = if ($contain) { 'media contain' } else { 'media' }
    [void]$cards.AppendLine(@"
  <a class="card" href="project-$slug.html" style="--ca:$($p.color)">
    <div class="$mc"><img src="$img" width="$w" height="$h" loading="lazy" decoding="async" alt="$(Esc $p.title)"></div>
    <div class="body"><span class="tag">$(Esc $p.tag)</span><h3>$(Esc $p.title)</h3><p>$(Esc $p.desc)</p><span class="cta">Xem chi tiết →</span></div>
  </a>
"@)
  }
  $sw = (($cats.Keys | ForEach-Object { $cc = $cats[$_]; '<a href="{0}"{1}>{2}</a>' -f $cc.file, $(if ($_ -eq $ck) { ' class="on"' } else { '' }), $cc.title }) -join '')
  $html = (Head ($c.title + ' — Dự án') $c.lead '#FF6B81' 'assets/projects/kimdong-1.webp') + @"
<body>
<nav class="nav"><a class="logo" href="index.html">KIÊN.</a><a class="back" href="index.html#$($c.anchor)">← Trang chủ</a></nav>
<header class="hero">
  <div class="aura"></div>
  <div class="eyebrow">Dự án · $($catOrder[$ck].Count) dự án</div>
  <h1>$(Esc $c.title) <span class="ghost">$(Esc $c.ghost)</span></h1>
  <p class="lead">$(Esc $c.lead)</p>
</header>
<div class="switch">$sw</div>
<main class="grid">
$($cards.ToString())
</main>
$footer
</body>
</html>
"@
  [IO.File]::WriteAllText("$root\$($c.file)", $html, $utf8)
  "wrote $($c.file)"
}
