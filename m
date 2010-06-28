MIME-Version: 1.0
Date: Mon, 28 Jun 2010 13:49:15 +0200
Message-ID: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>
From: Nape Ibrahim Lentsoane <nape.lentsoane@domain.hid>
Content-Type: multipart/alternative; boundary=00163630faa5ca2995048a15b550
Subject: [Xenomai-help] IRQ conflict issues with and ESD PMC card.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--00163630faa5ca2995048a15b550
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I've been having this problem for some time now and I hope someone from the
Xenomai community can help.
Basically, my kernel does not want to boot with PMC card. I have managed to
use console redirection of messages
to the serial port and I can see the error messages. From what I can see,
there is a problem with '*xnintr_irq_handler*' due
to this message at boot time: *Xenomai: xnintr_irq_handler: IRQ10 not
handled. Disabling IRQ line.*

I've tried enabling and disabling MSI and ACPI to no results so far. Now,
I'm on the verge of giving up.

Can someone please help? Will appreciate it. Below are the error messages I
can see:

*Loading, please wait...
usplash: libusplash.c:289: switch_console: Assertion `(saved_vt >= 0) &&
(saved_vt < 10)' failed.
 * Reading files needed to boot...       [80G
[74G[ OK ]
 * Setting preliminary keymap...       [80G
[74G[ OK ]
 * Preparing restricted drivers...       [80G
[74G[ OK ]
 * Setting the system clock
 * Starting basic networking...       [80G
[74G[ OK ]
 * Starting kernel event manager...       [80G
[74G[ OK ]
 * Loading hardware drivers...       [80G [   20.066925] Xenomai:
xnintr_irq_handler: IRQ10 not handled. Disabling IRQ line.
[   51.717947] ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6
frozen
[   51.725003] ata1.00: failed command: READ FPDMA QUEUED
[   51.730147] ata1.00: cmd 60/20:00:be:2c:d3/00:00:07:00:**00/40 tag 0 ncq
16384 in
[   51.730148]          res 40/00:00:00:00:00/00:00:00:00:**00/00 Emask 0x4
(timeout)
[   51.744842] ata1.00: status: { DRDY }
[   51.748508] ata1.00: failed command: READ FPDMA QUEUED
[   51.753652] ata1.00: cmd 60/08:08:c6:b1:6a/00:00:04:00:**00/40 tag 1 ncq
4096 in
[   51.753654]          res 40/00:00:00:00:00/00:00:00:00:**00/00 Emask 0x4
(timeout)
[   51.768260] ata1.00: status: { DRDY }
[   57.076943] ata1.00: revalidation failed (errno=-5)
[   67.385942] ata1.00: revalidation failed (errno=-5)
[   97.694945] ata1.00: revalidation failed (errno=-5)
[   98.003986] end_request: I/O error, dev sda, sector 74101190
[   98.009661] EXT3-fs error (device sda5): ext3_get_inode_loc: unable to
read inode block - inode=1794219, block=7176199
[   98.020416] end_request: I/O error, dev sda, sector 131280062
[   98.026199] end_request: I/O error, dev sda, sector 131280062
[   98.034310] end_request: I/O error, dev sda, sector 74101190
[   98.039995] EXT3-fs error (device sda5): ext3_get_inode_loc: unable to
read inode block - inode=1794219, block=7176199
[   98.056359] end_request: I/O error, dev sda, sector 131672150
[   98.062957] end_request: I/O error, dev sda, sector 131672150
[   98.069040] end_request: I/O error, dev sda, sector 131673750
[   98.074832] end_request: I/O error, dev sda, sector 131673750
[   98.083955] end_request: I/O error, dev sda, sector 131672150
[   98.090748] end_request: I/O error, dev sda, sector 67285454
[   98.096424] EXT3-fs error (device sda5): ext3_get_inode_loc: unable to
read inode block - inode=1581257, block=6324232
[   98.107193] end_request: I/O error, dev sda, sector 67285454
[   98.112862] EXT3-fs error (device sda5): ext3_get_inode_loc: unable to
read inode block - inode=1581257, block=6324232
[   98.131240] end_request: I/O error, dev sda, sector 70544622
[   98.136908] EXT3-fs error (device sda5): ext3_find_entry: reading
directory #1679441 offset 0
[   98.145534] end_request: I/O error, dev sda, sector 70544622
[   98.151197] EXT3-fs error (device sda5): ext3_find_entry: reading
directory #1679441 offset 0
[   98.181764] end_request: I/O error, dev sda, sector 16691638
[   98.187429] Buffer I/O error on device sda5, logical block 5
[   98.193086] Buffer I/O error on device sda5, logical block 6
[   98.198746] Buffer I/O error on device sda5, logical block 7
[   98.204405] Buffer I/O error on device sda5, logical block 8
[   98.210063] Buffer I/O error on device sda5, logical block 9
[   98.215723] Buffer I/O error on device sda5, logical block 10
[   98.221470] Buffer I/O error on device sda5, logical block 11
[   98.227216] Buffer I/O error on device sda5, logical block 12
[   98.232963] Buffer I/O error on device sda5, logical block 13
[   98.238710] Buffer I/O error on device sda5, logical block 14
[   98.244527] end_request: I/O error, dev sda, sector 16691638
[   98.257058] end_request: I/O error, dev sda, sector 150513048
[   98.262864] end_request: I/O error, dev sda, sector 150513048
[   98.268681] end_request: I/O error, dev sda, sector 150513048
[   98.274461] end_request: I/O error, dev sda, sector 150513048
[   98.295949] end_request: I/O error, dev sda, sector 73446142
[   98.301629] EXT3-fs error (device sda5): ext3_find_entry: reading
directory #1769517 offset 0
[   98.315970] end_request: I/O error, dev sda, sector 16691638
[   98.321996] end_request: I/O error, dev sda, sector 150513048
[   98.327833] end_request: I/O error, dev sda, sector 150513216
[   98.333645] end_request: I/O error, dev sda, sector 150513048
[   98.339465] end_request: I/O error, dev sda, sector 156296216
[   98.345253] end_request: I/O error, dev sda, sector 156296216
[   98.351437] end_request: I/O error, dev sda, sector 156296216
[   98.357219] end_request: I/O error, dev sda, sector 156296216
[   98.363144] end_request: I/O error, dev sda, sector 150513048
[   98.368971] end_request: I/O error, dev sda, sector 150513048
[   98.374918] end_request: I/O error, dev sda, sector 63
[   98.380104] end_request: I/O error, dev sda, sector 63
[   98.385290] end_request: I/O error, dev sda, sector 16691391
[   98.390977] end_request: I/O error, dev sda, sector 16691391
[   98.396724] end_request: I/O error, dev sda, sector 16691391
[   98.402417] end_request: I/O error, dev sda, sector 16691391
[   98.408141] end_request: I/O error, dev sda, sector 63
[   98.413317] end_request: I/O error, dev sda, sector 63
[   98.418542] end_request: I/O error, dev sda, sector 16691638
[   98.424269] end_request: I/O error, dev sda, sector 156296216
[   98.430058] end_request: I/O error, dev sda, sector 156296216
[   98.435980] end_request: I/O error, dev sda, sector 150513048
[   98.441806] end_request: I/O error, dev sda, sector 150513048
[   98.449165] end_request: I/O error, dev sda, sector 16702006
[   98.454864] end_request: I/O error, dev sda, sector 16702006
[   98.460573] end_request: I/O error, dev sda, sector 16710206
[   98.466268] end_request: I/O error, dev sda, sector 16710206
[   98.471975] end_request: I/O error, dev sda, sector 16702006
[   98.477667] end_request: I/O error, dev sda, sector 16710206
[   98.483466] end_request: I/O error, dev sda, sector 16701902
[   98.489216] end_request: I/O error, dev sda, sector 16953742
[   98.494944] end_request: I/O error, dev sda, sector 16953742
[   98.500665] end_request: I/O error, dev sda, sector 16953742
[   98.506385] end_request: I/O error, dev sda, sector 16953742
[   98.512106] end_request: I/O error, dev sda, sector 16953742
[   98.517826] end_request: I/O error, dev sda, sector 16953742
[   98.523546] end_request: I/O error, dev sda, sector 16953742
[   98.529267] end_request: I/O error, dev sda, sector 16953742
[   98.534992] end_request: I/O error, dev sda, sector 16953742
[   98.540716] end_request: I/O error, dev sda, sector 16953742
[   98.546439] end_request: I/O error, dev sda, sector 16953742
[   98.552166] end_request: I/O error, dev sda, sector 16953742
[   98.557885] end_request: I/O error, dev sda, sector 16953742
[   98.563605] end_request: I/O error, dev sda, sector 16953742
[   98.569327] end_request: I/O error, dev sda, sector 16953742
[   98.575046] end_request: I/O error, dev sda, sector 16953742
[   98.580766] end_request: I/O error, dev sda, sector 16953742
[   98.586488] end_request: I/O error, dev sda, sector 16953742
[   98.592213] end_request: I/O error, dev sda, sector 16953742
[   98.597924] end_request: I/O error, dev sda, sector 16953742
[   98.603636] end_request: I/O error, dev sda, sector 16953742
[   98.609350] end_request: I/O error, dev sda, sector 16953742
[   98.615058] end_request: I/O error, dev sda, sector 16953742
[   98.620770] end_request: I/O error, dev sda, sector 16953742
[   98.626511] end_request: I/O error, dev sda, sector 16953742
[   98.632302] end_request: I/O error, dev sda, sector 16953742
[   98.633313] end_request: I/O error, dev sda, sector 16953742
[   98.634314] end_request: I/O error, dev sda, sector 16953742
[   98.635310] end_request: I/O error, dev sda, sector 16953742
[   98.636311] end_request: I/O error, dev sda, sector 16953742
[   98.637309] end_request: I/O error, dev sda, sector 16953742
[   98.638309] end_request: I/O error, dev sda, sector 16953742
[   98.639309] end_request: I/O error, dev sda, sector 16953742
[   98.640312] end_request: I/O error, dev sda, sector 16953742
[   98.641308] end_request: I/O error, dev sda, sector 16953742
[   98.642308] end_request: I/O error, dev sda, sector 16953742
[   98.643308] end_request: I/O error, dev sda, sector 16953742
[   98.644308] end_request: I/O error, dev sda, sector 16953742
[   98.645308] end_request: I/O error, dev sda, sector 16953742
[   98.646308] end_request: I/O error, dev sda, sector 16953742
[   98.647307] end_request: I/O error, dev sda, sector 16953742
[   98.648308] end_request: I/O error, dev sda, sector 16953742
[   98.649307] end_request: I/O error, dev sda, sector 16953742
[   98.650307] end_request: I/O error, dev sda, sector 16953742
[   98.651310] end_request: I/O error, dev sda, sector 16953742
[   98.652307] end_request: I/O error, dev sda, sector 16953742
[   98.653306] end_request: I/O error, dev sda, sector 16953742
[   98.655294] end_request: I/O error, dev sda, sector 16953742
[   98.656306] end_request: I/O error, dev sda, sector 16953742
[   98.657306] end_request: I/O error, dev sda, sector 16953742
[   98.658306] end_request: I/O error, dev sda, sector 16953742
[   98.659305] end_request: I/O error, dev sda, sector 16953742
[   98.660305] end_request: I/O error, dev sda, sector 16953742
[   98.661305] end_request: I/O error, dev sda, sector 16953742
[   98.663283] end_request: I/O error, dev sda, sector 16953742
[   98.664308] end_request: I/O error, dev sda, sector 16953742
[   98.665305] end_request: I/O error, dev sda, sector 16953742
[   98.666304] end_request: I/O error, dev sda, sector 16953742
[   98.667304] end_request: I/O error, dev sda, sector 16953742
[   98.668304] end_request: I/O error, dev sda, sector 16953742
[   98.669304] end_request: I/O error, dev sda, sector 16953742
[   98.671269] end_request: I/O error, dev sda, sector 16953742
[   98.672303] end_request: I/O error, dev sda, sector 16953742
[   98.673304] end_request: I/O error, dev sda, sector 16953742
[   98.674303] end_request: I/O error, dev sda, sector 16953742
[   98.675303] end_request: I/O error, dev sda, sector 16953742
[   98.676306] end_request: I/O error, dev sda, sector 16953742
[   98.677303] end_request: I/O error, dev sda, sector 16953742
[   98.679250] end_request: I/O error, dev sda, sector 16953742
[   98.680302] end_request: I/O error, dev sda, sector 16953742
[   98.681302] end_request: I/O error, dev sda, sector 16953742
[   98.682302] end_request: I/O error, dev sda, sector 16953742
[   98.683302] end_request: I/O error, dev sda, sector 16953742
[   98.684302] end_request: I/O error, dev sda, sector 16953742
[   98.685301] end_request: I/O error, dev sda, sector 16953742
[   98.686301] end_request: I/O error, dev sda, sector 16953742
[   98.687301] end_request: I/O error, dev sda, sector 16953742
[   98.688305] end_request: I/O error, dev sda, sector 16953742
[   98.689301] end_request: I/O error, dev sda, sector 16953742
[   98.690301] end_request: I/O error, dev sda, sector 16953742
[   98.691301] end_request: I/O error, dev sda, sector 16953742
[   98.692300] end_request: I/O error, dev sda, sector 16953742
[   98.693300] end_request: I/O error, dev sda, sector 16953742
[   98.694300] end_request: I/O error, dev sda, sector 16953742
[   98.695300] end_request: I/O error, dev sda, sector 16953742
[   98.696300] end_request: I/O error, dev sda, sector 16953742
[   98.697300] end_request: I/O error, dev sda, sector 16953742
[   98.698300] end_request: I/O error, dev sda, sector 16953742
[   98.699304] end_request: I/O error, dev sda, sector 16953742
[   98.700299] end_request: I/O error, dev sda, sector 16953742
[   98.701299] end_request: I/O error, dev sda, sector 16953742
[   98.702299] end_request: I/O error, dev sda, sector 16953742
[   98.703299] end_request: I/O error, dev sda, sector 16953742
[   98.704298] end_request: I/O error, dev sda, sector 16953742
[   98.705298] end_request: I/O error, dev sda, sector 16953742
[   98.706298] end_request: I/O error, dev sda, sector 16953742
[   98.707298] end_request: I/O error, dev sda, sector 16953742
[   98.708298] end_request: I/O error, dev sda, sector 16953742
[   98.709298] end_request: I/O error, dev sda, sector 16953742
[   98.710301] end_request: I/O error, dev sda, sector 16953742
[   98.711298] end_request: I/O error, dev sda, sector 16953742
[   98.712297] end_request: I/O error, dev sda, sector 16953742
[   98.713297] end_request: I/O error, dev sda, sector 16953742
[   98.714297] end_request: I/O error, dev sda, sector 16953742
[   98.715297] end_request: I/O error, dev sda, sector 16953742
[   98.716297] end_request: I/O error, dev sda, sector 16953742
[   98.718293] end_request: I/O error, dev sda, sector 16953742
[   98.719297] end_request: I/O error, dev sda, sector 16953742
[   98.720296] end_request: I/O error, dev sda, sector 16953742
[   98.721296] end_request: I/O error, dev sda, sector 16953742
[   98.722299] end_request: I/O error, dev sda, sector 16953742
[   98.723296] end_request: I/O error, dev sda, sector 16953742
[   98.724295] end_request: I/O error, dev sda, sector 16953742
[   98.726283] end_request: I/O error, dev sda, sector 16953742
[   98.727295] end_request: I/O error, dev sda, sector 16953742
[   98.728295] end_request: I/O error, dev sda, sector 16953742
[   98.729295] end_request: I/O error, dev sda, sector 16953742
[   98.730295] end_request: I/O error, dev sda, sector 16953742
[   98.731294] end_request: I/O error, dev sda, sector 16953742
[   98.732294] end_request: I/O error, dev sda, sector 16953742
[   98.734272] end_request: I/O error, dev sda, sector 16953742
[   98.735294] end_request: I/O error, dev sda, sector 16953742
[   98.736297] end_request: I/O error, dev sda, sector 16953742
[   98.737293] end_request: I/O error, dev sda, sector 16953742
[   98.738293] end_request: I/O error, dev sda, sector 16953742
[   98.739293] end_request: I/O error, dev sda, sector 16953742
[   98.740293] end_request: I/O error, dev sda, sector 16953742
[   98.742254] end_request: I/O error, dev sda, sector 16953742
[   98.743293] end_request: I/O error, dev sda, sector 16953742
[   98.744293] end_request: I/O error, dev sda, sector 16953742
[   98.745292] end_request: I/O error, dev sda, sector 16953742
[   98.746292] end_request: I/O error, dev sda, sector 16953742
[   98.747292] end_request: I/O error, dev sda, sector 16953742
[   98.748295] end_request: I/O error, dev sda, sector 16953742
[   98.749293] end_request: I/O error, dev sda, sector 16953742
[   98.750292] end_request: I/O error, dev sda, sector 16953742
[   98.751291] end_request: I/O error, dev sda, sector 16953742
[   98.752291] end_request: I/O error, dev sda, sector 16953742
[   98.753291] end_request: I/O error, dev sda, sector 16953742
[   98.754291] end_request: I/O error, dev sda, sector 16953742
[   98.755291] end_request: I/O error, dev sda, sector 16953742
[   98.756291] end_request: I/O error, dev sda, sector 16953742
[   98.757290] end_request: I/O error, dev sda, sector 16953742
[   98.758290] end_request: I/O error, dev sda, sector 16953742
[   98.759295] end_request: I/O error, dev sda, sector 16953742
[   98.760290] end_request: I/O error, dev sda, sector 16953742
[   98.761290] end_request: I/O error, dev sda, sector 16953742
[   98.762290] end_request: I/O error, dev sda, sector 16953742
[   98.763290] end_request: I/O error, dev sda, sector 16953742
[   98.764289] end_request: I/O error, dev sda, sector 16953742
[   98.765289] end_request: I/O error, dev sda, sector 16953742
[   98.766290] end_request: I/O error, dev sda, sector 16953742
[   98.767289] end_request: I/O error, dev sda, sector 16953742
[   98.768289] end_request: I/O error, dev sda, sector 16953742
[   98.769291] end_request: I/O error, dev sda, sector 16953742
[   98.770292] end_request: I/O error, dev sda, sector 16953742
[   98.771288] end_request: I/O error, dev sda, sector 16953742
[   98.772288] end_request: I/O error, dev sda, sector 16953742
[   98.773288] end_request: I/O error, dev sda, sector 16953742
[   98.774288] end_request: I/O error, dev sda, sector 16953742
[   98.775288] end_request: I/O error, dev sda, sector 16953742
[   98.776287] end_request: I/O error, dev sda, sector 16953742
[   98.777287] end_request: I/O error, dev sda, sector 16953742
[   98.778287] end_request: I/O error, dev sda, sector 16953742
[   98.779287] end_request: I/O error, dev sda, sector 16953742
[   98.780287] end_request: I/O error, dev sda, sector 16953742
[   98.781290] end_request: I/O error, dev sda, sector 16953742
[   98.782287] end_request: I/O error, dev sda, sector 16953742
[   98.783287] end_request: I/O error, dev sda, sector 16953742
[   98.784286] end_request: I/O error, dev sda, sector 16953742
[   98.785286] end_request: I/O error, dev sda, sector 16953742
[   98.786286] end_request: I/O error, dev sda, sector 16953742
[   98.788283] end_request: I/O error, dev sda, sector 16953742
[   98.789286] end_request: I/O error, dev sda, sector 16953742
[   98.790285] end_request: I/O error, dev sda, sector 16953742
[   98.791285] end_request: I/O error, dev sda, sector 16953742
[   98.792285] end_request: I/O error, dev sda, sector 16953742
[   98.793288] end_request: I/O error, dev sda, sector 16953742
[   98.794285] end_request: I/O error, dev sda, sector 16953742
[   98.796272] end_request: I/O error, dev sda, sector 16953742
[   98.797284] end_request: I/O error, dev sda, sector 16953742
[   98.798284] end_request: I/O error, dev sda, sector 16953742
[   98.799284] end_request: I/O error, dev sda, sector 16953742
[   98.800284] end_request: I/O error, dev sda, sector 16953742
[   98.801284] end_request: I/O error, dev sda, sector 16953742
[   98.802283] end_request: I/O error, dev sda, sector 16953742
[   98.804260] end_request: I/O error, dev sda, sector 16953742
[   98.805283] end_request: I/O error, dev sda, sector 16953742
[   98.806287] end_request: I/O error, dev sda, sector 16953742
[   98.807283] end_request: I/O error, dev sda, sector 16953742
[   98.808283] end_request: I/O error, dev sda, sector 16953742
[   98.809283] end_request: I/O error, dev sda, sector 16953742
[   98.810282] end_request: I/O error, dev sda, sector 16953742
[   98.812256] end_request: I/O error, dev sda, sector 16953742
[   98.813282] end_request: I/O error, dev sda, sector 16953742
[   98.814282] end_request: I/O error, dev sda, sector 16953742
[   98.815281] end_request: I/O error, dev sda, sector 16953742
[   98.816281] end_request: I/O error, dev sda, sector 16953742
[   98.817281] end_request: I/O error, dev sda, sector 16953742
[   98.818281] end_request: I/O error, dev sda, sector 16953742
[   98.820247] end_request: I/O error, dev sda, sector 16953742
[   98.821282] end_request: I/O error, dev sda, sector 16953742
[   98.822281] end_request: I/O error, dev sda, sector 16953742
[   98.823280] end_request: I/O error, dev sda, sector 16953742
[   98.824280] end_request: I/O error, dev sda, sector 16953742
[   98.825280] end_request: I/O error, dev sda, sector 16953742
[   98.826280] end_request: I/O error, dev sda, sector 16953742
[   98.828233] end_request: I/O error, dev sda, sector 16953742
[   98.829279] end_request: I/O error, dev sda, sector 16953742
[   98.830279] end_request: I/O error, dev sda, sector 16953742
[   98.831279] end_request: I/O error, dev sda, sector 16953742
[   98.832283] end_request: I/O error, dev sda, sector 16953742
[   98.833279] end_request: I/O error, dev sda, sector 16953742
[   98.834279] end_request: I/O error, dev sda, sector 16953742
[   98.836237] end_request: I/O error, dev sda, sector 16953742
[   98.837278] end_request: I/O error, dev sda, sector 16953742
[   98.838278] end_request: I/O error, dev sda, sector 16953742
[   98.839279] end_request: I/O error, dev sda, sector 16953742
[   98.840278] end_request: I/O error, dev sda, sector 16953742
[   98.841278] end_request: I/O error, dev sda, sector 16953742
[   98.842278] end_request: I/O error, dev sda, sector 16953742
[   98.843277] end_request: I/O error, dev sda, sector 16953742
[   98.844281] end_request: I/O error, dev sda, sector 16953742
[   98.845277] end_request: I/O error, dev sda, sector 16953742
[   98.846277] end_request: I/O error, dev sda, sector 16953742
[   98.847277] end_request: I/O error, dev sda, sector 16953742
[   98.848277] end_request: I/O error, dev sda, sector 16953742
[   98.849277] end_request: I/O error, dev sda, sector 16953742
[   98.850276] end_request: I/O error, dev sda, sector 16953742
[   98.851276] end_request: I/O error, dev sda, sector 16953742
[   98.852276] end_request: I/O error, dev sda, sector 16953742
[   98.853276] end_request: I/O error, dev sda, sector 16953742
[   98.854276] end_request: I/O error, dev sda, sector 16953742
[   98.855280] end_request: I/O error, dev sda, sector 16953742
[   98.856276] end_request: I/O error, dev sda, sector 16953742
[   98.857275] end_request: I/O error, dev sda, sector 16953742
[   98.858275] end_request: I/O error, dev sda, sector 16953742
[   98.859275] end_request: I/O error, dev sda, sector 16953742
[   98.860275] end_request: I/O error, dev sda, sector 16953742
[   98.861275] end_request: I/O error, dev sda, sector 16953742
[   98.862275] end_request: I/O error, dev sda, sector 16953742
[   98.863274] end_request: I/O error, dev sda, sector 16953742
[   98.864274] end_request: I/O error, dev sda, sector 16953742
[   98.865274] end_request: I/O error, dev sda, sector 16953742
[   98.866279] end_request: I/O error, dev sda, sector 16953742
[   98.867274] end_request: I/O error, dev sda, sector 16953742
[   98.868274] end_request: I/O error, dev sda, sector 16953742
[   98.869273] end_request: I/O error, dev sda, sector 16953742
[   98.870273] end_request: I/O error, dev sda, sector 16953742
[   98.871273] end_request: I/O error, dev sda, sector 16953742
[   98.872273] end_request: I/O error, dev sda, sector 16953742
[   98.873273] end_request: I/O error, dev sda, sector 16953742
[   98.874273] end_request: I/O error, dev sda, sector 16953742
[   98.875273] end_request: I/O error, dev sda, sector 16953742
[   98.876272] end_request: I/O error, dev sda, sector 16953742
[   98.877276] end_request: I/O error, dev sda, sector 16953742
[   98.878272] end_request: I/O error, dev sda, sector 16953742
[   98.879272] end_request: I/O error, dev sda, sector 16953742
[   98.880272] end_request: I/O error, dev sda, sector 16953742
[   98.882263] end_request: I/O error, dev sda, sector 16953742
[   98.883271] end_request: I/O error, dev sda, sector 16953742
[   98.884272] end_request: I/O error, dev sda, sector 16953742
[   98.885271] end_request: I/O error, dev sda, sector 16953742
[   98.886271] end_request: I/O error, dev sda, sector 16953742
[   98.887271] end_request: I/O error, dev sda, sector 16953742
[   98.888271] end_request: I/O error, dev sda, sector 16953742
[   98.890255] end_request: I/O error, dev sda, sector 16953742
[   98.891270] end_request: I/O error, dev sda, sector 16953742
[   98.892270] end_request: I/O error, dev sda, sector 16953742
[   98.893270] end_request: I/O error, dev sda, sector 16953742
[   98.894270] end_request: I/O error, dev sda, sector 16953742
[   98.895269] end_request: I/O error, dev sda, sector 16953742
[   98.896269] end_request: I/O error, dev sda, sector 16953742
[   98.898238] end_request: I/O error, dev sda, sector 16953742
[   98.899269] end_request: I/O error, dev sda, sector 16953742
[   98.900269] end_request: I/O error, dev sda, sector 16953742
[   98.901268] end_request: I/O error, dev sda, sector 16953742
[   98.902277] end_request: I/O error, dev sda, sector 16953742
[   98.903268] end_request: I/O error, dev sda, sector 16953742
[   98.904268] end_request: I/O error, dev sda, sector 16953742
[   98.906234] end_request: I/O error, dev sda, sector 16953742
[   98.907268] end_request: I/O error, dev sda, sector 16953742
[   98.908267] end_request: I/O error, dev sda, sector 16953742
[   98.909268] end_request: I/O error, dev sda, sector 16953742
[   98.910267] end_request: I/O error, dev sda, sector 16953742
[   98.911267] end_request: I/O error, dev sda, sector 16953742
[   98.912267] end_request: I/O error, dev sda, sector 16953742
[   98.914214] end_request: I/O error, dev sda, sector 16953742
[   98.915266] end_request: I/O error, dev sda, sector 16953742
[   98.916271] end_request: I/O error, dev sda, sector 16953742
[   98.917266] end_request: I/O error, dev sda, sector 16953742
[   98.918266] end_request: I/O error, dev sda, sector 16953742
[   98.919266] end_request: I/O error, dev sda, sector 16953742
[   98.920266] end_request: I/O error, dev sda, sector 16953742
[   98.921265] end_request: I/O error, dev sda, sector 16953742
[   98.922265] end_request: I/O error, dev sda, sector 16953742
[   98.923265] end_request: I/O error, dev sda, sector 16953742
[   98.924265] end_request: I/O error, dev sda, sector 16953742
[   98.925265] end_request: I/O error, dev sda, sector 16953742
[   98.926265] end_request: I/O error, dev sda, sector 16953742
[   98.927269] end_request: I/O error, dev sda, sector 16953742
[   98.928265] end_request: I/O error, dev sda, sector 16953742
[   98.929264] end_request: I/O error, dev sda, sector 16953742
[   98.930264] end_request: I/O error, dev sda, sector 16953742
[   98.931264] end_request: I/O error, dev sda, sector 16953742
[   98.932266] end_request: I/O error, dev sda, sector 16953742
[   98.933264] end_request: I/O error, dev sda, sector 16953742
[   98.934264] end_request: I/O error, dev sda, sector 16953742
[   98.935263] end_request: I/O error, dev sda, sector 16953742
[   98.936263] end_request: I/O error, dev sda, sector 16953742
[   98.937263] end_request: I/O error, dev sda, sector 16953742
[   98.938267] end_request: I/O error, dev sda, sector 16953742
[   98.939263] end_request: I/O error, dev sda, sector 16953742
[   98.940263] end_request: I/O error, dev sda, sector 16953742
[   98.941262] end_request: I/O error, dev sda, sector 16953742
[   98.942262] end_request: I/O error, dev sda, sector 16953742
[   98.943262] end_request: I/O error, dev sda, sector 16953742
[   98.944262] end_request: I/O error, dev sda, sector 16953742
[   98.945262] end_request: I/O error, dev sda, sector 16953742
[   98.946262] end_request: I/O error, dev sda, sector 16953742
[   98.947261] end_request: I/O error, dev sda, sector 16953742
[   98.948261] end_request: I/O error, dev sda, sector 16953742
[   98.949265] end_request: I/O error, dev sda, sector 16953742
[   98.950261] end_request: I/O error, dev sda, sector 16953742
[   98.951261] end_request: I/O error, dev sda, sector 16953742
[   98.952261] end_request: I/O error, dev sda, sector 16953742
[   98.953261] end_request: I/O error, dev sda, sector 16953742
[   98.954262] end_request: I/O error, dev sda, sector 16953742
[   98.955261] end_request: I/O error, dev sda, sector 16953742
[   98.956261] end_request: I/O error, dev sda, sector 16953742
[   98.957261] end_request: I/O error, dev sda, sector 16953742
[   98.958261] end_request: I/O error, dev sda, sector 16953742
[   98.960257] end_request: I/O error, dev sda, sector 16953742
[   98.961265] end_request: I/O error, dev sda, sector 16953742
[   98.962261] end_request: I/O error, dev sda, sector 16953742
[   98.963261] end_request: I/O error, dev sda, sector 16953742
[   98.964261] end_request: I/O error, dev sda, sector 16953742
[   98.965261] end_request: I/O error, dev sda, sector 16953742
[   98.966261] end_request: I/O error, dev sda, sector 16953742
[   98.968248] end_request: I/O error, dev sda, sector 16953742
[   98.969261] end_request: I/O error, dev sda, sector 16953742
[   98.970261] end_request: I/O error, dev sda, sector 16953742
[   98.971261] end_request: I/O error, dev sda, sector 16953742
[   98.972261] end_request: I/O error, dev sda, sector 16953742
[   98.973266] end_request: I/O error, dev sda, sector 16953742
[   98.974261] end_request: I/O error, dev sda, sector 16953742
[   98.976247] end_request: I/O error, dev sda, sector 16953742
[   98.977261] end_request: I/O error, dev sda, sector 16953742
[   98.978261] end_request: I/O error, dev sda, sector 16953742
[   98.979262] end_request: I/O error, dev sda, sector 16953742
[   98.980261] end_request: I/O error, dev sda, sector 16953742
[   98.981261] end_request: I/O error, dev sda, sector 16953742
[   98.982261] end_request: I/O error, dev sda, sector 16953742
[   98.984236] end_request: I/O error, dev sda, sector 16953742
[   98.985261] end_request: I/O error, dev sda, sector 16953742
[   98.986265] end_request: I/O error, dev sda, sector 16953742
[   98.987261] end_request: I/O error, dev sda, sector 16953742
[   98.988261] end_request: I/O error, dev sda, sector 16953742
[   98.989261] end_request: I/O error, dev sda, sector 16953742
[   98.990261] end_request: I/O error, dev sda, sector 16953742
[   98.992233] end_request: I/O error, dev sda, sector 16953742
[   98.993261] end_request: I/O error, dev sda, sector 16953742
[   98.994261] end_request: I/O error, dev sda, sector 16953742
[   98.995261] end_request: I/O error, dev sda, sector 16953742
[   98.996261] end_request: I/O error, dev sda, sector 16953742
[   98.997261] end_request: I/O error, dev sda, sector 16953742
[   98.998267] end_request: I/O error, dev sda, sector 16953742
[   99.000233] end_request: I/O error, dev sda, sector 16953742
[   99.001261] end_request: I/O error, dev sda, sector 16953742
[   99.002261] end_request: I/O error, dev sda, sector 16953742
[   99.003261] end_request: I/O error, dev sda, sector 16953742
[  130.635267] end_request: I/O error, dev sda, sector 16691606
[  130.636214] Buffer I/O error on device sda5, logical block 1
[  130.637241] end_request: I/O error, dev sda, sector 16691614
[  130.638211] Buffer I/O error on device sda5, logical block 2
[  130.639214] Buffer I/O error on device sda5, logical block 3
[  130.640213] Buffer I/O error on device sda5, logical block 4
*

--00163630faa5ca2995048a15b550
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I&#39;ve been having this problem for some time now and I hop=
e someone from the Xenomai community can help.<br>Basically, my kernel does=
 not want to boot with PMC card. I have managed to use console redirection =
of messages<br>

to the serial port and I can see the error messages. From what I can see, t=
here is a problem with &#39;<i>xnintr_irq_handler</i>&#39; due<br>to this m=
essage at boot time: <i>Xenomai: xnintr_irq_handler: IRQ10 not handled. Dis=
abling IRQ line.</i> <br>

<br>I&#39;ve tried enabling and disabling MSI and ACPI to no results so far=
. Now, I&#39;m on the verge of giving up.<br><br>Can someone please help? W=
ill appreciate it. Below are the error messages I can see:<br><br><i>Loadin=
g, please wait...<br>
usplash: libusplash.c:289: switch_console: Assertion `(saved_vt &gt;=3D 0) =
&amp;&amp; (saved_vt &lt; 10)&#39; failed.<br>
=A0* Reading files needed to boot...=A0=A0=A0=A0=A0=A0  [80G <br> [74G[ OK =
]<br>=A0* Setting preliminary keymap...=A0=A0=A0=A0=A0=A0  [80G <br> [74G[ =
OK ]<br>=A0* Preparing restricted drivers...=A0=A0=A0=A0=A0=A0  [80G <br> [=
74G[ OK ]<br>=A0* Setting the system clock<br>

=A0* Starting basic networking...=A0=A0=A0=A0=A0=A0  [80G <br> [74G[ OK ]<b=
r>=A0* Starting kernel event manager...=A0=A0=A0=A0=A0=A0  [80G <br> [74G[ =
OK ]<br>=A0* Loading hardware drivers...=A0=A0=A0=A0=A0=A0  [80G [=A0=A0 20=
.066925] Xenomai: xnintr_irq_handler: IRQ10 not handled. Disabling IRQ line=
.<br>

[=A0=A0 51.717947] ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x=
6 frozen<br>[=A0=A0 51.725003] ata1.00: failed command: READ FPDMA QUEUED<b=
r>[=A0=A0 51.730147] ata1.00: cmd 60/20:00:be:2c:d3/00:00:07:00:</i><i>00/4=
0 tag 0 ncq 16384 in<br>

[=A0=A0 51.730148]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 40/00:00:00:00:00/00:00:0=
0:00:</i><i>00/00 Emask 0x4 (timeout)<br>[=A0=A0 51.744842] ata1.00: status=
: { DRDY }<br>[=A0=A0 51.748508] ata1.00: failed command: READ FPDMA QUEUED=
<br>[=A0=A0 51.753652] ata1.00: cmd 60/08:08:c6:b1:6a/00:00:04:00:</i><i>00=
/40 tag 1 ncq 4096 in<br>

[=A0=A0 51.753654]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 40/00:00:00:00:00/00:00:0=
0:00:</i><i>00/00 Emask 0x4 (timeout)<br>[=A0=A0 51.768260] ata1.00: status=
: { DRDY }<br>[=A0=A0 57.076943] ata1.00: revalidation failed (errno=3D-5)<=
br>[=A0=A0 67.385942] ata1.00: revalidation failed (errno=3D-5)<br>

[=A0=A0 97.694945] ata1.00: revalidation failed (errno=3D-5)<br>[=A0=A0 98.=
003986] end_request: I/O error, dev sda, sector 74101190<br>[=A0=A0 98.0096=
61] EXT3-fs error (device sda5): ext3_get_inode_loc: unable to read inode b=
lock - inode=3D1794219, block=3D7176199<br>

[=A0=A0 98.020416] end_request: I/O error, dev sda, sector 131280062<br>[=
=A0=A0 98.026199] end_request: I/O error, dev sda, sector 131280062<br>[=A0=
=A0 98.034310] end_request: I/O error, dev sda, sector 74101190<br>[=A0=A0 =
98.039995] EXT3-fs error (device sda5): ext3_get_inode_loc: unable to read =
inode block - inode=3D1794219, block=3D7176199<br>

[=A0=A0 98.056359] end_request: I/O error, dev sda, sector 131672150<br>[=
=A0=A0 98.062957] end_request: I/O error, dev sda, sector 131672150<br>[=A0=
=A0 98.069040] end_request: I/O error, dev sda, sector 131673750<br>[=A0=A0=
 98.074832] end_request: I/O error, dev sda, sector 131673750<br>

[=A0=A0 98.083955] end_request: I/O error, dev sda, sector 131672150<br>[=
=A0=A0 98.090748] end_request: I/O error, dev sda, sector 67285454<br>[=A0=
=A0 98.096424] EXT3-fs error (device sda5): ext3_get_inode_loc: unable to r=
ead inode block - inode=3D1581257, block=3D6324232<br>

[=A0=A0 98.107193] end_request: I/O error, dev sda, sector 67285454<br>[=A0=
=A0 98.112862] EXT3-fs error (device sda5): ext3_get_inode_loc: unable to r=
ead inode block - inode=3D1581257, block=3D6324232<br>[=A0=A0 98.131240] en=
d_request: I/O error, dev sda, sector 70544622<br>

[=A0=A0 98.136908] EXT3-fs error (device sda5): ext3_find_entry: reading di=
rectory #1679441 offset 0<br>[=A0=A0 98.145534] end_request: I/O error, dev=
 sda, sector 70544622<br>[=A0=A0 98.151197] EXT3-fs error (device sda5): ex=
t3_find_entry: reading directory #1679441 offset 0<br>

[=A0=A0 98.181764] end_request: I/O error, dev sda, sector 16691638<br>[=A0=
=A0 98.187429] Buffer I/O error on device sda5, logical block 5<br>[=A0=A0 =
98.193086] Buffer I/O error on device sda5, logical block 6<br>[=A0=A0 98.1=
98746] Buffer I/O error on device sda5, logical block 7<br>

[=A0=A0 98.204405] Buffer I/O error on device sda5, logical block 8<br>[=A0=
=A0 98.210063] Buffer I/O error on device sda5, logical block 9<br>[=A0=A0 =
98.215723] Buffer I/O error on device sda5, logical block 10<br>[=A0=A0 98.=
221470] Buffer I/O error on device sda5, logical block 11<br>

[=A0=A0 98.227216] Buffer I/O error on device sda5, logical block 12<br>[=
=A0=A0 98.232963] Buffer I/O error on device sda5, logical block 13<br>[=A0=
=A0 98.238710] Buffer I/O error on device sda5, logical block 14<br>[=A0=A0=
 98.244527] end_request: I/O error, dev sda, sector 16691638<br>

[=A0=A0 98.257058] end_request: I/O error, dev sda, sector 150513048<br>[=
=A0=A0 98.262864] end_request: I/O error, dev sda, sector 150513048<br>[=A0=
=A0 98.268681] end_request: I/O error, dev sda, sector 150513048<br>[=A0=A0=
 98.274461] end_request: I/O error, dev sda, sector 150513048<br>

[=A0=A0 98.295949] end_request: I/O error, dev sda, sector 73446142<br>[=A0=
=A0 98.301629] EXT3-fs error (device sda5): ext3_find_entry: reading direct=
ory #1769517 offset 0<br>[=A0=A0 98.315970] end_request: I/O error, dev sda=
, sector 16691638<br>

[=A0=A0 98.321996] end_request: I/O error, dev sda, sector 150513048<br>[=
=A0=A0 98.327833] end_request: I/O error, dev sda, sector 150513216<br>[=A0=
=A0 98.333645] end_request: I/O error, dev sda, sector 150513048<br>[=A0=A0=
 98.339465] end_request: I/O error, dev sda, sector 156296216<br>

[=A0=A0 98.345253] end_request: I/O error, dev sda, sector 156296216<br>[=
=A0=A0 98.351437] end_request: I/O error, dev sda, sector 156296216<br>[=A0=
=A0 98.357219] end_request: I/O error, dev sda, sector 156296216<br>[=A0=A0=
 98.363144] end_request: I/O error, dev sda, sector 150513048<br>

[=A0=A0 98.368971] end_request: I/O error, dev sda, sector 150513048<br>[=
=A0=A0 98.374918] end_request: I/O error, dev sda, sector 63<br>[=A0=A0 98.=
380104] end_request: I/O error, dev sda, sector 63<br>[=A0=A0 98.385290] en=
d_request: I/O error, dev sda, sector 16691391<br>

[=A0=A0 98.390977] end_request: I/O error, dev sda, sector 16691391<br>[=A0=
=A0 98.396724] end_request: I/O error, dev sda, sector 16691391<br>[=A0=A0 =
98.402417] end_request: I/O error, dev sda, sector 16691391<br>[=A0=A0 98.4=
08141] end_request: I/O error, dev sda, sector 63<br>

[=A0=A0 98.413317] end_request: I/O error, dev sda, sector 63<br>[=A0=A0 98=
.418542] end_request: I/O error, dev sda, sector 16691638<br>[=A0=A0 98.424=
269] end_request: I/O error, dev sda, sector 156296216<br>[=A0=A0 98.430058=
] end_request: I/O error, dev sda, sector 156296216<br>

[=A0=A0 98.435980] end_request: I/O error, dev sda, sector 150513048<br>[=
=A0=A0 98.441806] end_request: I/O error, dev sda, sector 150513048<br>[=A0=
=A0 98.449165] end_request: I/O error, dev sda, sector 16702006<br>[=A0=A0 =
98.454864] end_request: I/O error, dev sda, sector 16702006<br>

[=A0=A0 98.460573] end_request: I/O error, dev sda, sector 16710206<br>[=A0=
=A0 98.466268] end_request: I/O error, dev sda, sector 16710206<br>[=A0=A0 =
98.471975] end_request: I/O error, dev sda, sector 16702006<br>[=A0=A0 98.4=
77667] end_request: I/O error, dev sda, sector 16710206<br>

[=A0=A0 98.483466] end_request: I/O error, dev sda, sector 16701902<br>[=A0=
=A0 98.489216] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.494944] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.5=
00665] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.506385] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.512106] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.517826] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.5=
23546] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.529267] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.534992] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.540716] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.5=
46439] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.552166] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.557885] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.563605] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.5=
69327] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.575046] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.580766] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.586488] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.5=
92213] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.597924] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.603636] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.609350] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
15058] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.620770] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.626511] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.632302] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
33313] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.634314] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.635310] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.636311] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
37309] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.638309] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.639309] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.640312] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
41308] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.642308] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.643308] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.644308] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
45308] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.646308] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.647307] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.648308] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
49307] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.650307] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.651310] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.652307] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
53306] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.655294] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.656306] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.657306] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
58306] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.659305] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.660305] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.661305] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
63283] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.664308] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.665305] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.666304] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
67304] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.668304] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.669304] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.671269] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
72303] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.673304] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.674303] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.675303] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
76306] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.677303] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.679250] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.680302] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
81302] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.682302] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.683302] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.684302] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
85301] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.686301] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.687301] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.688305] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
89301] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.690301] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.691301] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.692300] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
93300] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.694300] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.695300] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.696300] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.6=
97300] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.698300] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.699304] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.700299] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
01299] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.702299] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.703299] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.704298] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
05298] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.706298] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.707298] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.708298] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
09298] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.710301] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.711298] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.712297] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
13297] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.714297] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.715297] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.716297] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
18293] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.719297] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.720296] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.721296] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
22299] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.723296] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.724295] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.726283] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
27295] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.728295] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.729295] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.730295] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
31294] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.732294] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.734272] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.735294] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
36297] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.737293] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.738293] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.739293] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
40293] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.742254] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.743293] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.744293] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
45292] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.746292] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.747292] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.748295] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
49293] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.750292] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.751291] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.752291] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
53291] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.754291] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.755291] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.756291] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
57290] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.758290] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.759295] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.760290] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
61290] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.762290] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.763290] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.764289] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
65289] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.766290] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.767289] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.768289] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
69291] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.770292] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.771288] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.772288] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
73288] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.774288] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.775288] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.776287] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
77287] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.778287] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.779287] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.780287] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
81290] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.782287] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.783287] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.784286] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
85286] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.786286] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.788283] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.789286] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
90285] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.791285] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.792285] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.793288] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
94285] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.796272] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.797284] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.798284] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.7=
99284] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.800284] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.801284] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.802283] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
04260] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.805283] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.806287] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.807283] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
08283] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.809283] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.810282] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.812256] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
13282] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.814282] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.815281] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.816281] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
17281] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.818281] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.820247] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.821282] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
22281] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.823280] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.824280] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.825280] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
26280] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.828233] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.829279] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.830279] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
31279] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.832283] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.833279] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.834279] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
36237] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.837278] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.838278] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.839279] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
40278] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.841278] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.842278] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.843277] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
44281] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.845277] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.846277] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.847277] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
48277] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.849277] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.850276] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.851276] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
52276] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.853276] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.854276] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.855280] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
56276] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.857275] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.858275] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.859275] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
60275] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.861275] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.862275] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.863274] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
64274] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.865274] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.866279] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.867274] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
68274] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.869273] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.870273] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.871273] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
72273] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.873273] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.874273] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.875273] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
76272] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.877276] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.878272] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.879272] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
80272] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.882263] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.883271] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.884272] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
85271] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.886271] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.887271] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.888271] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
90255] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.891270] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.892270] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.893270] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
94270] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.895269] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.896269] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.898238] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.8=
99269] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.900269] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.901268] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.902277] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
03268] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.904268] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.906234] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.907268] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
08267] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.909268] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.910267] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.911267] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
12267] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.914214] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.915266] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.916271] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
17266] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.918266] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.919266] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.920266] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
21265] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.922265] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.923265] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.924265] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
25265] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.926265] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.927269] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.928265] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
29264] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.930264] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.931264] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.932266] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
33264] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.934264] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.935263] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.936263] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
37263] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.938267] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.939263] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.940263] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
41262] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.942262] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.943262] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.944262] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
45262] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.946262] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.947261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.948261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
49265] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.950261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.951261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.952261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
53261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.954262] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.955261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.956261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
57261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.958261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.960257] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.961265] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
62261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.963261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.964261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.965261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
66261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.968248] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.969261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.970261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
71261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.972261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.973266] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.974261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
76247] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.977261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.978261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.979262] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
80261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.981261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.982261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.984236] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
85261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.986265] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.987261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.988261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
89261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.990261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.992233] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.993261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
94261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 98.995261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 98.996261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
98.997261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 98.9=
98267] end_request: I/O error, dev sda, sector 16953742<br>

[=A0=A0 99.000233] end_request: I/O error, dev sda, sector 16953742<br>[=A0=
=A0 99.001261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 =
99.002261] end_request: I/O error, dev sda, sector 16953742<br>[=A0=A0 99.0=
03261] end_request: I/O error, dev sda, sector 16953742<br>

[=A0 130.635267] end_request: I/O error, dev sda, sector 16691606<br>[=A0 1=
30.636214] Buffer I/O error on device sda5, logical block 1<br>[=A0 130.637=
241] end_request: I/O error, dev sda, sector 16691614<br>[=A0 130.638211] B=
uffer I/O error on device sda5, logical block 2<br>

[=A0 130.639214] Buffer I/O error on device sda5, logical block 3<br>[=A0 1=
30.640213] Buffer I/O error on device sda5, logical block 4<br></i><br>

--00163630faa5ca2995048a15b550--

