Message-ID: <4ACDA23D.4000507@domain.hid>
Date: Thu, 08 Oct 2009 10:26:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0000ACAE.4ACDAF68@domain.hid>
In-Reply-To: <0000ACAE.4ACDAF68@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re : rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: oliver.schlenker@domain.hid
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

oliver.schlenker@domain.hid wrote:
>>> int main( int arc, char *argv[] ) { int i;
>>> 
>>> rt_print_auto_init(1);
>>> 
>>> rt_printf("--------------- TEST RT-PRINTF  1 ------------\n");
>>> 
>>> sleep(1);
>>> 
>>> daemon(0,0);
>>> 
>>> rt_print_auto_init(1);
> Ok, understood, at least for the scenario where the rt_print feature
> is initialised befor the fork/daemon call. What I don't understand
> is, why it does not work if the rt_print feature is initialised after
> the fork / daemon.

>From the way I understand your code, you never tried to initialize the
rt_print feature only after the fork, your code initializes it both
before and after.

-- 
                                          Gilles


