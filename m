Message-ID: <518BB895.3050208@xenomai.org>
Date: Thu, 09 May 2013 16:54:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>	<518A5F0C.50403@xenomai.org>	<CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>	<518ABA3D.5070106@xenomai.org>	<CAPpP=rOQm+GBuoB5KuAiAo5nG=HzggXb7CyLaP-SHAwebykPUw@mail.gmail.com>	<518B8C50.2050107@xenomai.org>	<CAPpP=rNkQTDCfRAxpN5wPNK-5R-4gngpxFGUCiqT2T8gwMKJRg@mail.gmail.com>	<518BA407.8020103@xenomai.org>	<CAPpP=rNCxHUfcBS7djmv8i+Er2PpXBdO101LfcxaZswzc9eBnw@mail.gmail.com>	<518BAF44.9060803@xenomai.org>	<CAPpP=rMLPeRAVCpdKQkLVD29pFUj8zPL5JRmTbrJkKEetJJbew@mail.gmail.com>
	<CAPpP=rM6BTevvfoV+TT4ej6zkeyzdnY7yN_qVCUPkLFe38EUYA@mail.gmail.com>
In-Reply-To: <CAPpP=rM6BTevvfoV+TT4ej6zkeyzdnY7yN_qVCUPkLFe38EUYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/09/2013 04:51 PM, alex alex wrote:

> Sorry for the last mail..
> 
> Here is what I've done.


I am interested in the code that does not work, is this the one? This
may trigger the bug that was fixed since 2.6.2.1 if the created thread
dies before pthread_set_name_np is called.

-- 
                                                                Gilles.

