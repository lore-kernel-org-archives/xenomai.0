Message-ID: <439F0806.4070206@domain.hid>
Date: Tue, 13 Dec 2005 18:42:30 +0100
From: Giuseppe Lipari <lipari@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] events and domains
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

Dear all,

We are new to Xenomai and Adeos. We have some questions and I could not
find answers to these in the documentation (but maybe we are not very
good at finding things!). We hope someone can help!

1) Adeos is able to handle events that are passed to domains.
I understand that events are hw interrupts and "other things". In the
docs, I see that an event can be a "soft interrupt". As soft interrupt
can have different meanings in different contexts, what do you actually
mean with "soft interrupt"??

2) Also, what exactly are hooks? In particular, when there is a
context-switch between two non-Xenomai (Linux) threads running in user
space, is any hook-event generated?

3) when a Xenomai thread starts executing, does it start in primary or
in secondary mode?

4) is the memory of a Xenomai thread allocated in user space? (I guess
yes, but just to be sure!)

5) if  two UVMs are active at the same time, how they are scheduled with
respect to each other? (I guess SCHED\_FIFO, but it looks somewhat
strange to me: why not SCHED\_RR, at least for the application tasks?).


Giuseppe Lipari and Paolo Gai



-- 
------------------------------------------------------
| Prof. Giuseppe Lipari      |
| RETIS Lab                  |
| Scuola Superiore Sant'Anna | tel:   +39 050 882030
| via G. Moruzzi, 1          | fax:   +39 050 882003
| 56124 Pisa (PI)            | email: lipari@domain.hid
------------------------------------------------------



