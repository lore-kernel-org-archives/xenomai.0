Message-ID: <4810488D.9030909@domain.hid>
Date: Thu, 24 Apr 2008 10:45:01 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <27116705.1209018431019.JavaMail.ngmail@domain.hid>
In-Reply-To: <27116705.1209018431019.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Current state of RTDM-native?
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
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

M. Koehrer wrote:
> Hi everybody,
> 
> by reading the homepage of http://www.osadl.org I was (again) led to the RTDM-native project which
> has as target to provide an RTDM port for standard Linux (using the RT Preempt Patch).
> Looking at the GNA page http://svn.gna.org/svn/xenomai/branches/rtdm-native 
> it seems to be fairly quiet...
> My long time "wish" is to have a real time standard linux with a real time capable UDP networking implementation.
> For the tasks and the required latency, the RT preempt patch seems to be fine for our application,
> however there is currently no way to get a realtime network system running.
> Thus, rtnet via RTDM via RT preempt patch seems to be perfect for our needs...
> 
> Does anybody knows of some activities on rtdm-native?

I do not know of any activities, but it should not be a big effort to
get RTnet ported over RTDM-native. As I see it, mainly the build system
of RTnet needs adaption.

Wolfgang.

