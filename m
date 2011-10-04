MIME-Version: 1.0
Date: Tue, 4 Oct 2011 04:48:50 -0400
Message-ID: <CAGc_wL210UJCguth0cD-MOJFvzTqZXmoikQuaCE8Q5TJOWGg1w@domain.hid>
From: Julien Delange <julien.delange@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] Using the analogy layer in kernel tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Dear all,

I would like to know if somebody already tried to migrate code of
user-space tasks that use the analogy layer to the kernel. As kernel
tasks may run faster than user-space, it might help to speed
application execution. However, when trying to load the application, I
encounter the following errors (see below). So, is the analogy layer
designed to be used in kernel tasks ? If yes, which functions are
allowed, which are forbidden (and in that case, it would be useful to
disable functions in
/lib/modules/KERNEL_VERSION/build/include/xenomai/analogy/ headers) ?

Thanks you for any comment/help regarding that topic,

Best regards,



[ 1560.700937] test_pcimio: Unknown symbol a4l_open (err 0)
[ 1560.701100] test_pcimio: Unknown symbol __floatsidf (err 0)
[ 1560.701634] test_pcimio: Unknown symbol __ltdf2 (err 0)
[ 1560.701863] test_pcimio: Unknown symbol a4l_get_chinfo (err 0)
[ 1560.702501] test_pcimio: Unknown symbol __fixdfsi (err 0)
[ 1560.702625] test_pcimio: Unknown symbol a4l_fill_desc (err 0)
[ 1560.702855] test_pcimio: Unknown symbol a4l_snd_insnlist (err 0)
[ 1560.702977] test_pcimio: Unknown symbol a4l_rawtod (err 0)
[ 1560.703099] test_pcimio: Unknown symbol a4l_get_rnginfo (err 0)
[ 1560.703682] test_pcimio: Unknown symbol a4l_find_range (err 0)
[ 1615.399804] test_pcimio: Unknown symbol a4l_open (err 0)
[ 1615.399944] test_pcimio: Unknown symbol __floatsidf (err 0)
[ 1615.400073] test_pcimio: Unknown symbol __ltdf2 (err 0)
[ 1615.400288] test_pcimio: Unknown symbol a4l_get_chinfo (err 0)
[ 1615.400288] test_pcimio: Unknown symbol __fixdfsi (err 0)
[ 1615.400288] test_pcimio: Unknown symbol a4l_fill_desc (err 0)
[ 1615.400786] test_pcimio: Unknown symbol a4l_snd_insnlist (err 0)
[ 1615.400910] test_pcimio: Unknown symbol a4l_rawtod (err 0)
[ 1615.401032] test_pcimio: Unknown symbol a4l_get_rnginfo (err 0)
[ 1615.401173] test_pcimio: Unknown symbol a4l_find_range (err 0)

