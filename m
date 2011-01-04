Message-ID: <4D2396A2.7070006@domain.hid>
Date: Tue, 04 Jan 2011 22:52:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D233AB4.5070702@domain.hid> <4D2352C9.9050006@domain.hid>
	<4D2377B5.1040807@domain.hid>
	<4D23785B.5050108@domain.hid> <4D2379EF.5@domain.hid>
	<4D237A89.3010205@domain.hid> <4D237CA9.2090408@domain.hid>
	<4D237F62.2030609@domain.hid> <4D2381B6.80304@domain.hid>
	<4D238C56.40906@domain.hid> <4D238EA1.7020409@domain.hid>
	<4D239001.9050604@domain.hid> <4D239301.80803@domain.hid>
In-Reply-To: <4D239301.80803@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Tamas Szklenar <tszklenar@domain.hid>
Cc: xenomai@xenomai.org

Tamas Szklenar wrote:
> Tick Device: mode:     0
> Broadcast device
> Clock Event Device: pit
>   mode:           2
> 
> 
> Tick Device: mode:     0
> Clock Event Device: lapic
>   mode:           1
> 
> Tick Device: mode:     0
> Clock Event Device: lapic
>   mode:           1
> 
> Tick Device: mode:     0
> Clock Event Device: lapic
>   mode:           1
> 
> Tick Device: mode:     0
> Clock Event Device: lapic
>   mode:           1

The pit is in broadcast mode and the lapic timers are in "shutdown" 
state, which means that Linux is using the PIT, and Xenomai fails to 
start because it tries to use the lapic.

That is probably related to the following messages in the kernel logs:
Jan  3 13:12:01 cfhat12 kernel: [    0.016000] System has AMD C1E enabled
Jan  3 13:12:01 cfhat12 kernel: [    0.160009] Switch to broadcast mode on CPU1
Jan  3 13:12:01 cfhat12 kernel: [    0.160090]  #2
Jan  3 13:12:01 cfhat12 kernel: [    0.252008] Switch to broadcast mode on CPU2
Jan  3 13:12:01 cfhat12 kernel: [    0.252052]  #3
Jan  3 13:12:01 cfhat12 kernel: [    0.016000] Switch to broadcast mode on CPU3
Jan  3 13:12:01 cfhat12 kernel: [    0.344033] Brought up 4 CPUs
Jan  3 13:12:01 cfhat12 kernel: [    0.344037] Total of 4 processors activated (27322.12 BogoMIPS).
Jan  3 13:12:01 cfhat12 kernel: [    0.345670] Switch to broadcast mode on CPU0

And explains the patch Philippe sent in the mean-time...


-- 
                                                                Gilles.

