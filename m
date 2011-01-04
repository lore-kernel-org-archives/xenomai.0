Message-ID: <4D237D5B.7080301@domain.hid>
Date: Tue, 04 Jan 2011 15:04:43 -0500
From: Tamas Szklenar <tszklenar@domain.hid>
MIME-Version: 1.0
References: <4D233AB4.5070702@domain.hid>
	<4D2352C9.9050006@domain.hid>	<4D2377B5.1040807@domain.hid>	<4D23785B.5050108@domain.hid>
	<4D2379EF.5@domain.hid> <4D237A89.3010205@domain.hid>
	<4D237B33.7080100@domain.hid>
In-Reply-To: <4D237B33.7080100@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai failure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi

Here are the sections from the log:

Jan  3 17:41:30 cfhat12 kernel: [    0.515140] I-pipe: Domain Xenomai 
registered.
Jan  3 17:41:30 cfhat12 kernel: [    0.515203] Xenomai: hal/x86_64 started.
Jan  3 17:41:30 cfhat12 kernel: [    0.515213] Xenomai: scheduling class 
idle registered.
Jan  3 17:41:30 cfhat12 kernel: [    0.515214] Xenomai: scheduling class 
rt registered.
Jan  3 17:41:30 cfhat12 kernel: [    0.516146] Xenomai: real-time 
nucleus v2.5.5.2 (Ghosts) loaded.

And the modprobe section:

Jan  3 17:42:57 cfhat12 kernel: [   95.590293] Xenomai: native skin init 
failed, code -19.
Jan  3 17:44:00 cfhat12 kernel: [  158.228673] Xenomai: starting POSIX 
services.
Jan  3 17:44:00 cfhat12 kernel: [  158.430504] Xenomai: POSIX skin init 
failed, code -19.
Jan  3 17:44:03 cfhat12 kernel: [  161.982511] Xenomai: RTDM skin init 
failed, code -19.


Tamas

