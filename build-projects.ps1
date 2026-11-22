# Tạo các trang project-*.html từ dữ liệu bên dưới. Chạy: powershell -File build-projects.ps1
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$manifest = Get-Content "$root\assets\projects\manifest.json" -Raw -Encoding UTF8 | ConvertFrom-Json

$projects = @(
  @{ slug='kimdong';   title='Kim Đồng Bookstore'; cat='Mobile App/Game'; anchor='apps';    color='#E8485E'; client='Nhà sách Kim Đồng'; kind='Thiết kế lại ứng dụng';
     desc='Thiết kế lại giao diện ứng dụng nhà sách Kim Đồng. Dự án cải thiện điều hướng, cá nhân hóa gợi ý và hiện đại hóa thiết kế, hướng tới trải nghiệm mua sắm liền mạch, hấp dẫn cho cả phụ huynh và các bạn đọc nhỏ tuổi, đúng với sứ mệnh gieo yêu thích đọc sách của Kim Đồng.'; tags=@('UX/UI','User flow','Mobile App') },
  @{ slug='heartwise'; title='HeartWise'; cat='Mobile App/Game'; anchor='apps'; color='#4CC76A'; client='Dự án UI/UX'; kind='Ứng dụng xây dựng thói quen';
     desc='Ứng dụng xây dựng thói quen ăn uống và vận động để phòng ngừa bệnh tim. HeartWise giúp bạn tạo lối sống lành mạnh mới bằng cách quản lý thói quen hằng ngày, theo dõi tiến độ và giữ động lực mỗi ngày qua các tương tác mang tính trò chơi.'; tags=@('UX/UI','Gamification','Mobile App') },
  @{ slug='vime';      title='VIME x TechPro'; cat='Web App'; anchor='systems'; color='#8B7CFF'; client='TechPro'; kind='Hệ thống quản lý phòng họp';
     desc='Nền tảng quản lý phòng họp và lịch họp cho doanh nghiệp do TechPro phát triển. VIME cung cấp giải pháp toàn diện để tối ưu việc đặt phòng, lên lịch họp và theo dõi hiệu quả sử dụng không gian làm việc, với giao diện hiện đại, thân thiện, dễ dùng.'; tags=@('Web App','Dashboard','Lịch họp') },
  @{ slug='vcb';       title='Vietcombank TCHM'; cat='Web App'; anchor='systems'; color='#3DBC8D'; client='Vietcombank'; kind='Hệ thống quản lý lưu trú';
     desc='Hệ thống quản lý lưu trú dành cho cán bộ, nhân viên Vietcombank. Hệ thống giúp quản lý toàn diện thông tin cư trú, sắp xếp chỗ ở hợp lý và theo dõi tình trạng phòng, hỗ trợ tối ưu vận hành, minh bạch trong quản lý và nâng cao chất lượng phúc lợi nội bộ.'; tags=@('Web App','Quản lý nội bộ','Dashboard') },
  @{ slug='pcu';       title='PCU x TDI Group'; cat='Web App'; anchor='systems'; color='#FF5C5C'; client='TDI Group'; kind='Nền tảng số hóa quy trình cung ứng';
     desc='Nền tảng hỗ trợ số hóa quy trình cho phòng cung ứng do TDI Group phát triển, là phần mềm nội bộ chuẩn hóa và tự động hóa các nghiệp vụ cung ứng, mua sắm và quản lý vật tư. Hệ thống hỗ trợ tạo và theo dõi yêu cầu mua hàng, kiểm soát quy trình phê duyệt, quản lý nhà cung cấp và cập nhật trạng thái đơn hàng theo thời gian thực.'; tags=@('Web App','Enterprise','Quy trình') },
  @{ slug='thinkiz';   title='Thinkiz x Effi AI'; cat='Web App'; anchor='systems'; color='#5EA8FF'; client='Effi AI'; kind='Không gian làm việc AI agent';
     desc='Thinkiz là nền tảng không gian làm việc dạng agentic do Effi AI xây dựng, giúp con người cộng tác với các AI agent trong mọi quy trình, từ nghiên cứu, tạo nội dung đa phương tiện đến điều phối vận hành. Bạn làm việc trên một canvas dự án, còn các agent tự động chia nhỏ nhiệm vụ, tìm thông tin, tạo tài liệu và lặp lại theo phản hồi của bạn.'; tags=@('Web App','AI','Dark UI') },
  @{ slug='forever';   title='Forever Young'; cat='Landing Page'; anchor='webs'; color='#FF9EC4'; client='Forever Young Company'; kind='Website công ty';
     desc='Website chính thức giới thiệu Forever Young, công ty quản lý KOL, ca sĩ và nhạc sĩ hàng đầu Việt Nam. Với sứ mệnh phát triển tài năng và xây dựng thương hiệu cá nhân, website cung cấp thông tin về dịch vụ quản lý chuyên nghiệp, các dự án nổi bật và câu chuyện thành công của nghệ sĩ.'; tags=@('Landing Page','Entertainment','Dark UI') },
  @{ slug='ielts';     title='IELTS Lab'; cat='Landing Page'; anchor='webs'; color='#6FA8FF'; client='IELTS LAB'; kind='Website trung tâm Anh ngữ';
     desc='Website giới thiệu trung tâm đào tạo tiếng Anh IELTS LAB, chuyên luyện thi IELTS cấp tốc với sứ mệnh giúp học viên đạt mục tiêu trong thời gian ngắn nhất. Website cung cấp thông tin chi tiết về khóa học, lịch học và tài nguyên hữu ích để học viên tự tin chinh phục kỳ thi.'; tags=@('Landing Page','Education','Responsive') }
)

function Esc($s) { [System.Net.WebUtility]::HtmlEncode($s) }

$tpl = @'
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{{TITLE}} — Nguyễn Trung Kiên, UI/UX Designer</title>
<meta name="description" content="{{DESC_ATTR}}">
<meta property="og:title" content="{{TITLE}} — Nguyễn Trung Kiên">
<meta property="og:description" content="{{DESC_ATTR}}">
<meta property="og:image" content="assets/projects/{{SLUG}}-1.webp">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Unbounded:wght@300;400;600;800&family=Be+Vietnam+Pro:wght@300;400;500;600&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
<style>
:root{--bg:#150A0F;--ink:#FBF2F4;--muted:#9C8B92;--accent:{{COLOR}};--line:rgba(251,242,244,.10);--display:'Unbounded',sans-serif;--body:'Be Vietnam Pro',sans-serif;--mono:'Space Mono',monospace}
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
.lead{max-width:640px;font-size:clamp(1rem,1.3vw,1.15rem);line-height:1.75;color:var(--muted);margin-top:5vh;position:relative}
.meta{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:28px;margin-top:7vh;padding-top:4vh;border-top:1px solid var(--line);position:relative}
.meta dt{font-family:var(--mono);font-size:.7rem;letter-spacing:.18em;text-transform:uppercase;color:var(--muted);margin-bottom:8px}
.meta dd{font-weight:500;font-size:1rem}
.tags{display:flex;flex-wrap:wrap;gap:8px}
.tags span{font-family:var(--mono);font-size:.72rem;letter-spacing:.06em;border:1px solid var(--line);border-radius:999px;padding:5px 12px}
.case{padding:2vh 5vw 10vh}
.case-inner{max-width:1400px;margin:0 auto;border-radius:20px;overflow:hidden;background:#0D060A;border:1px solid var(--line)}
.case-inner img{background:#0D060A}
.pager{display:grid;grid-template-columns:1fr 1fr;border-top:1px solid var(--line)}
.pager a{padding:7vh 5vw;display:flex;flex-direction:column;gap:12px;transition:background .4s}
.pager a:hover{background:rgba(251,242,244,.04)}
.pager a+a{border-left:1px solid var(--line);text-align:right;align-items:flex-end}
.pager small{font-family:var(--mono);font-size:.72rem;letter-spacing:.18em;text-transform:uppercase;color:var(--muted)}
.pager strong{font-family:var(--display);font-weight:600;font-size:clamp(1.1rem,2.8vw,2.2rem);text-transform:uppercase}
.pager a:hover strong{color:var(--accent)}
footer{padding:6vh 5vw;border-top:1px solid var(--line);display:flex;flex-wrap:wrap;gap:16px 40px;justify-content:space-between;font-family:var(--mono);font-size:.78rem;letter-spacing:.08em;color:var(--muted)}
footer a:hover{color:var(--accent)}
@media(max-width:700px){.nav .logo{font-size:.9rem}.pager{grid-template-columns:1fr}.pager a+a{border-left:0;border-top:1px solid var(--line);text-align:left;align-items:flex-start}.case-inner{border-radius:12px}}
@media(prefers-reduced-motion:reduce){html{scroll-behavior:auto}}
</style>
</head>
<body>
<nav class="nav"><a class="logo" href="index.html">KIÊN.</a><a class="back" href="index.html#{{ANCHOR}}">← Tất cả dự án</a></nav>
<header class="hero">
  <div class="aura"></div>
  <div class="eyebrow">{{CAT}}</div>
  <h1>{{TITLE}}</h1>
  <p class="lead">{{DESC}}</p>
  <dl class="meta">
    <div><dt>Khách hàng / Đơn vị</dt><dd>{{CLIENT}}</dd></div>
    <div><dt>Loại dự án</dt><dd>{{KIND}}</dd></div>
    <div><dt>Vai trò</dt><dd>UI/UX Designer</dd></div>
    <div><dt>Nội dung</dt><dd class="tags">{{TAGS}}</dd></div>
  </dl>
</header>
<main class="case"><div class="case-inner">
{{IMAGES}}
</div></main>
<nav class="pager" aria-label="Dự án khác">
  <a href="{{PREV_SLUG}}"><small>← Dự án trước</small><strong>{{PREV_TITLE}}</strong></a>
  <a href="{{NEXT_SLUG}}"><small>Dự án tiếp →</small><strong>{{NEXT_TITLE}}</strong></a>
</nav>
<footer>
  <span>© Nguyễn Trung Kiên</span>
  <a href="https://www.facebook.com/ntrugkien1510/" target="_blank" rel="noopener">Facebook</a>
  <a href="https://www.behance.net/croster1510" target="_blank" rel="noopener">Behance</a>
</footer>

</body>
</html>
'@

# thứ tự trong trang chủ: apps -> systems -> webs
$order = @('kimdong','heartwise','vime','vcb','pcu','thinkiz','forever','ielts')
$bySlug = @{}; foreach ($p in $projects) { $bySlug[$p.slug] = $p }

for ($i = 0; $i -lt $order.Count; $i++) {
  $p = $bySlug[$order[$i]]
  $prev = $bySlug[$order[($i + $order.Count - 1) % $order.Count]]
  $next = $bySlug[$order[($i + 1) % $order.Count]]
  $imgs = ($manifest.($p.slug) | ForEach-Object -Begin { $n = 0 } -Process {
      $n++
      $lazy = if ($n -eq 1) { 'eager' } else { 'lazy' }
      '<img src="assets/projects/{0}" width="{1}" height="{2}" loading="{3}" decoding="async" alt="{4} — phần {5}">' -f $_.f, $_.w, $_.h, $lazy, (Esc $p.title), $n
  }) -join "`n"
  $tags = ($p.tags | ForEach-Object { '<span>' + (Esc $_) + '</span>' }) -join ''
  $html = $tpl
  $map = @{
    '{{TITLE}}' = (Esc $p.title); '{{DESC}}' = (Esc $p.desc); '{{DESC_ATTR}}' = (Esc $p.desc); '{{SLUG}}' = $p.slug;
    '{{COLOR}}' = $p.color; '{{ANCHOR}}' = $p.anchor; '{{CAT}}' = (Esc $p.cat); '{{CLIENT}}' = (Esc $p.client);
    '{{KIND}}' = (Esc $p.kind); '{{TAGS}}' = $tags; '{{IMAGES}}' = $imgs;
    '{{PREV_SLUG}}' = "project-$($prev.slug).html"; '{{PREV_TITLE}}' = (Esc $prev.title);
    '{{NEXT_SLUG}}' = "project-$($next.slug).html"; '{{NEXT_TITLE}}' = (Esc $next.title)
  }
  foreach ($k in $map.Keys) { $html = $html.Replace($k, $map[$k]) }
  [IO.File]::WriteAllText("$root\project-$($p.slug).html", $html, (New-Object Text.UTF8Encoding($false)))
  "wrote project-$($p.slug).html"
}
