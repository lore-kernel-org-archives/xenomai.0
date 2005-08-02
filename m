Message-ID: <42EFF665.3060000@domain.hid>
Date: Wed, 03 Aug 2005 00:40:37 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] do_gettimeofday in ADEOS ISR
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi all!

I was just wondering if calling do_gettimeofday in an ADEOS interrupt
handler might cause any problems whatsoever ?

My ISR:
flags = adeos_critical_enter (NULL);
[...]
do_gettimeofday()
[...]
adeos_critical_exit (flags);

I saw that the code for do_gettimeofday is different in kernel 2.4 and
kernel 2.6:

Kernel 2.4:
void do_gettimeofday(struct timeval *tv) {
[...]
read_lock_irqsave(&xtime_lock, flags);
[...]
read_unlock_irqrestore(&xtime_lock, flags);

Kernel 2.6:
void do_gettimeofday(struct timeval *tv) {
[...]
do {
[...]
seq = read_seqbegin(&xtime_lock);
[...]
} while (read_seqretry(&xtime_lock, seq));

Well, read_lock_irqsave in 2.4 looks like a possible source for trouble,
while read_seqbegin in 2.6 doesn't do anything with interrupts, right ?

Thanks for all comments!

Best regards,
Hannes.

