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
  var cur=0,z=1,MAX=4,MIN=1,lastFocus=null;
  function setZ(nz,cx,cy){
    nz=Math.max(MIN,Math.min(MAX,nz)); if(nz===z)return;
    var r=st.getBoundingClientRect(); cx=cx==null?r.width/2:cx; cy=cy==null?r.height/2:cy;
    var px=(st.scrollLeft+cx)/(im.offsetWidth||1), py=(st.scrollTop+cy)/(im.offsetHeight||1);
    z=nz; im.style.width=(z*100)+'%'; st.classList.toggle('z',z>1); zl.textContent=Math.round(z*100)+'%';
    st.scrollLeft=px*im.offsetWidth-cx; st.scrollTop=py*im.offsetHeight-cy;
  }
  function show(i){
    cur=(i+items.length)%items.length; var it=items[cur], src=it.querySelector('img');
    im.src=src.getAttribute('data-full')||src.currentSrc||src.src; im.alt=src.alt; im.style.width='100%'; z=1; st.classList.remove('z'); zl.textContent='100%';
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
  if ($a.manifest) { $lm = $landMan.$slug; $hw = @([string]$lm.hero[0], [string]$lm.hero[1]) } else { $hw = $a.hero.Split('x') }
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine('<main class="case"><div class="fg-wrap">')
  [void]$sb.AppendLine(('<div class="fg-hero"><img src="assets/projects/{0}-web{4}.webp" width="{1}" height="{2}" loading="eager" decoding="async" alt="{3}"></div>' -f $slug, $hw[0], $hw[1], $a.title, $(if ($a.cols -eq 3) { '2' } else { '' })))
  [void]$sb.AppendLine('<h2 class="fg-title">Màn hình thiết kế</h2>')
  $gcls = if ($a.cols -eq 3) { 'fg-grid cols3' } else { 'fg-grid' }
  [void]$sb.AppendLine("<div class=`"$gcls`">")
  for ($i = 0; $i -lt $a.caps.Count; $i++) {
    $cap = [System.Net.WebUtility]::HtmlEncode($a.caps[$i])
    $wcls = if ($a.win -and $a.win[$i]) { 'fg-img win' } else { 'fg-img' }
    if ($a.manifest) {
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
