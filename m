Message-ID: <458A67B6.8000207@domain.hid>
Date: Thu, 21 Dec 2006 11:53:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <458A4DE0.5030005@domain.hid>
	<31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45894179.8060805@domain.hid> <4587E404.2050101@domain.hid>
	<4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
In-Reply-To: <2890274.1166696466862.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

M. Koehrer wrote:
> Hi Jan, hi everybody,
> 
> I have stripped down my program that is crashing Xenomai even further.
> (I have attached the complete source code).
> No rtnet is required.
> Now I have the following real time task:
> 
> static void realtimetask(void *arg)
> {
>     system("ls -l");

If you want to use system (or any function calling fork, eg popen or
vfork) with Xenomai, you have to make sure to fault all pages mapped
with write permission after the fork before trying to use services in
priimary mode, because fork write protects all pages with write
permission and notably the threads stacks. A piece of code that faults
all pages follows.

static void fault_vm(void)
{
        FILE *maps = fopen("/proc/self/maps", "r");
        unsigned begin, end, pagesize=getpagesize();
        char buffer[128];
        int rc;

        if (!maps) {
                perror("fopen");
                exit(EXIT_FAILURE);
        }

        while ((rc = fscanf(maps, "%x-%x",&begin, &end) == 2)) {
                fgets(buffer, 128, maps);

                if(buffer[2] != 'w')
                        continue;

                for (; begin != end; begin += pagesize)
                        *(volatile int *) begin = *(volatile int *) begin;
        }

        fclose(maps);
}


-- 
                                                 Gilles Chanteperdrix

