Received: from sonic301-47.consmr.mail.ir2.yahoo.com (sonic301-47.consmr.mail.ir2.yahoo.com [77.238.176.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21F4A36
	for <xenomai@lists.linux.dev>; Tue, 21 Feb 2023 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676988949; bh=K7Zm4fcX93CD+uSVRr+WvyUpuBLIQZ26D4AgF3YpU70=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=YPElEO6Ymx/iXaaYI9uo7bYJFyOtZtcPQmPRgp/f+BRRMmb8/1GYHQNMDUwB/2rV9xZaRjsFJfJ5VimtPnY8GbdXaN5OqLldfk2rf4zBw2HWxQuQs3Zn1ZkJYogd+3psVXcDRuFK+uRbDICCW1a4honul5V+QiIUyiNHmEfRQ+G43wP5RE2O8ufiodl2AV9yqeKlofDyEnxns34y6uDeZlJE9wowzoFUp6Pp0kBAdzf382IhinEYSsn1A8DXYTvWA0Lp5/8bJDRS7ZtGd+J9AV2PZLw0yLm4OuPa2BXP3RhPsFSAIu/LWfZ8g3QLPWgRJgbZTZ2D2fkAjZgIHan0hA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676988949; bh=9fJvp13gHWxb0S283qUPxt5qBHerM3K7nUn5mpiTw98=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=TCgM5Bln48HVs70ESLZx2irYQnbiJwVaq2WWpNdoHdOQe5AwBEKBwO6SFKgViVBH8CTmZJjRRVIpmDVURCxUJMHHM8qfWs91eOzDJ6bWeTKlbi/t3/TjCcy289g6YbjtNR4SGFJn5ffqo2KoqWnrLedBCme0AI5LZafXxW97iWi88mWZ5I4BlSue5xxvpZqTw1ge6djBYdefTxvrJvEJGe1Lrrd/BrIyzWX7Eh14JjnrdIKOMknhNjDP9g7ZwGXFCdOegqSGtUCVeZtx+3muI1nbFG7qQhDcycgtWTd0CBHsQLKlwgmNcaGmtH8rO22wniYFEag+faoR0KNpKZQMfg==
X-YMail-OSG: 4E0_HjgVM1kXsql0nGn3U_qzBGlGFJH1l7GFICQ_7G7s8DeuVlYrlcdqwffyB4i
 cKvI_vrw.NxZ3dehB49b62pU4ic_U3uW1O7xyfoP8Xu__vVfoM.03veXsgy0qSD4MqItAkhMzmN8
 RHdgd.RXKKsx9x9Hh685qwyJ2Xj5VOdRDgDgOdH9ifAo7Y.0jdbVQj7eJLFBvVddqWtgo2nvCweK
 sKAHYj33DBBNg14QvquFKLR9CCqDQ5SW74DOfb_dN1p4DHnp9fqwuMrPJt6Vz1q8jPjP7gxkvyRr
 VngmzZFHBg.sf5q8e4Wm0FD.T6YL3L2ACJwZwDQzaeK1GJyvZOaqQnz3Y6AKA8OxBMWKM9R2vJQG
 we1vyNFoozwOvEEAHh5MqxwbQ92JHD2nAAmZjr1pqf1oonBR0m_qLIjLy5Jhj3HHsKB4v6t4ftZt
 B2L5uIPyhrTe8sTS3cAZflJgTJJR0BZXnAumUd1d_RY8IaiK2jxbmC4WOKrOKFBn.rHQ5WdO1Gd1
 3Sj4RtFH.Ce_IjkFV4hwNogSj2ehsZjbsFydjrkUx49eB8YBQM1s7rqOz36dW_Z05xKST5h_kfc9
 0E.eDCyRtaQMdzdG2tdCoNO8Z9z1xF3RBWvh6.Ab1Nfd6a85LUBntL8tD_aBq5DBFA.PaLpt8YOn
 83EdsUQhgNbD83OEOENUFFJCMv_NJVMCiK1MjxRo8p_6P3Asy1TMhbZ0STvNkVum0HHPUMHcpOW0
 VwPhyBtJMLc.G2scJYqMQrVry_DVStGrR4ke6iTex38RTVAnIU9qacY5V.P8f0bBuct1sZMKyATc
 eMbpKfpsA.cZUg6H7ZYLuY9AvFdyrkykfmjfiTsr98Ui3Zmfc3WU8tE2J7RQeRi8jTCABn__ALPw
 3xzaY3IuUyevHayCJ_9gF4MhLM_3t1lG4ybeVKFaEXXz8DHSM9Y.2rvTcSGZ__N0ArmA5kEm6kiJ
 KXu_07KUtxitQd8kl7KuwbrvWqdkF_K9QBjEpszi2s2bggctmjCFB66RVFbYZqESCyektlBbwrDt
 unIRWi.iBsl6mCMvUuWhcj69YuPmpiWhQtKFMyryn5MeFG9mXcwFmY3.DfKN0CSl5i.yNytTyadZ
 1xTglu6HAdQtwL0I2M2.ZC8IHeGHt5r0yauzkW_fvqcGUMz.4GL00KkdKn1gIGwKupf7KaxmJ4zS
 FGoukzdcztwSFTfrf88TCrnkOtxuT4Osm.B6Iu_vCvj6cV4w6Fsl7jGGz1_BpzX1cHoa_ySr3.Ns
 wdXkLqFZwdd3hLRA_CDVui0AaSJWCdoVlQVYCHMo8hd6zLpfu4nbqUYIfe.Zh7r8yJ5D1ZdSHvp8
 ZmWyu_k5jpDJKh9G162rs2uDMSLbBf1.rjuDzD2.wUv42LysCeU233KcGZMHwtUENc9E1mgIhW9P
 ECmEUC4xBpayKz5A6et8ushhQEwvNh7UJXcGKBjBERarD8lyjHd_Mywh8iX5aEQyA_8UnzQo_qhL
 xA69XH_RX51LI0CusWae.94xc2W2qbsupNX2k2imu8i3oGsSdsPxkFWSYKwNouO_OXAOhUJcbk8N
 1xQD24sCDaphMMDk4xrmyGU3bIEKlM1cwDyjSTxxyMLHSZFpUH3ErglzT3TiaU0xiutjaiTgt2qP
 pOU.oKyEj4Y5mZo31WnabmKPMcFkfahjib6.job5oBH4YKoFo6erH9v4A.HznvdkLqcUPUCP3S26
 gKWZP27j7CUSi9VyEDAyCvg6G3OVCER.ViASzJ3ar1x6iIEq4KUeV3AozCC_7VE2mFRy13WP3wvj
 HZ5TEg.RTrTdk.onKsDvFGJ6vKKgu7URq1fzHAkfuSdJsjj_f7DHmWZ0NNG59_P5JiMd7o_zFkaF
 pNKXHFoB_.RG.qjpVZg0RxoeBJ23Dh5CbklAQL7t.XiSFDqq1KzW2fFGLD6ubJn8Nkw_v2wnglG_
 L2QNNL2xJqGsrlNoDJPzgEedj1Xn.JlWnRwxvmsAi5JNAmqfmCBynGz.vztiOVHclJ3GSKeGRpmv
 UqFtbGr1k24UqdiKh06EbWUNWMsIOYBLXjWuYH7GJ9E0wOUG8dNs6e_5ae.CGg78M2sXPgiktSXq
 hqZdZA4BvPIG6MfNlx_qS_A10Ox_FdcW7fskXXMOsrnavD8oQMKpqsiVRUaSrFgB3wJHV9Ek2dF4
 0fv9H99.49pxl182liKLSaeBD.hOtZzuGymEh68a8zi.Sj.ZBkML6xDTHtTXfxAzGx2nvwSMOJON
 Y504-
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Feb 2023 14:15:49 +0000
Received: by hermes--production-ir2-65c64dfd66-svnc4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9b71a2a0e3c23254a4799f715a54c5c1;
          Tue, 21 Feb 2023 14:13:48 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------v2WWHpC0t40lK2cTvYU5CwrO"
Message-ID: <233902a7-0911-06e8-a54b-dd7a1d568264@yahoo.com>
Date: Tue, 21 Feb 2023 15:13:46 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: it-IT
From: "Mauro S." <mau.salvi@yahoo.com>
Subject: Segfault on exit after commit ec804ffbd "lib/copperplate: Release
 main threadobj on exit"
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <233902a7-0911-06e8-a54b-dd7a1d568264.ref@yahoo.com>
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is a multi-part message in MIME format.
--------------v2WWHpC0t40lK2cTvYU5CwrO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm using Xenomai 3.2.2 at commit ec804ffbd, kernel 5.4.228, cobalt 
mode, on a Atom x5-E8000 x86-64.

Since I trarted to use the commit in message, I have a subtle segfault 
when I close my application.

I managed to reduce the case in the simple code attached to the message.
If you run the script, almost always the 
xeno-test-session-segfault-mainproc generates a segfault at exit.

Analyzing the core, the involved code is always the same:

#0  0x00007ff729498400 in __hash_key () from /usr/lib/libcobalt.so.2
#1  0x00007ff729498897 in hash_remove () from /usr/lib/libcobalt.so.2
#2  0x00007ff7294b49ac in syncluster_delobj () from 
/usr/lib/libcopperplate.so.0
#3  0x00007ff7294ce06d in ?? () from /usr/lib/libalchemy.so.0
#4  0x00007ff7294b6774 in semobj_destroy () from 
/usr/lib/libcopperplate.so.0
#5  0x00007ff7294ce216 in rt_sem_delete () from /usr/lib/libalchemy.so.0
#6  0x0000559ca0298651 in SubDummyFn (arg=<optimized out>) at main_proc.c:55
#7  0x00007ff7294cca0a in ?? () from /usr/lib/libalchemy.so.0
#8  0x00007ff7294b5ce9 in ?? () from /usr/lib/libcopperplate.so.0
#9  0x00007ff729494f7e in ?? () from /usr/lib/libcobalt.so.2
#10 0x00007ff729461ea4 in start_thread (arg=<optimized out>) at 
pthread_create.c:477
#11 0x00007ff72937859f in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Reverting the commit in object the segfault disappears.

Applying the commit to 3.1 branch results in the same problem.

Seems to be a corruption of the session memory shared between processes 
caused by the atexit() callback introduced by the commit.

Some notes:
- seems that it depends on when the xeno-test-session-segfault-secproc 
exits: if exit happens during the SubDummy tasks start, the segfault is 
generated, otherwise no
- seems to be related with the number of calls of the 
xeno-test-session-segfault-secproc: with only one call (change i == 2 
with i == 1 at main_proc.c:139 and remove one call in the script), the 
problem does not happen

Thanks in advance, regards.

-- 
Mauro S.
--------------v2WWHpC0t40lK2cTvYU5CwrO
Content-Type: application/x-xz; name="session_segfault_test.tar.xz"
Content-Disposition: attachment; filename="session_segfault_test.tar.xz"
Content-Transfer-Encoding: base64

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

--------------v2WWHpC0t40lK2cTvYU5CwrO--
