Message-ID: <4F5E51E2.1020802@domain.hid>
Date: Mon, 12 Mar 2012 20:43:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1331579565.394426122@domain.hid>
In-Reply-To: <1331579565.394426122@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Intermixing native and POSIX skins
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Doug Brunner <dbrunner@domain.hid>
Cc: xenomai@xenomai.org

On 03/12/2012 08:12 PM, Doug Brunner wrote:
> I'd like to be able to use native skin communications services (most importantly real time pipes) from a thread created with the POSIX skin. Is this safe?

Yes, that's fine. You could also use the XDDP protocol (cross-domain 
datagram) implemented by the RTIPC Xenomai driver for exactly the same 
purpose, with a socket-based interface as a bonus.

>
> I'm doing this because I'm building a C++ library that can use either real-time communications services, when used with a real-time application, or regular Linux pipe I/O, when used with a Linux application; these services are called by tasks that need to exist in both cases. I'd like to make the tasks always POSIX threads to eliminate the need for a bunch of wrappers and preprocessor ugliness that I put there to support either skin, depending on which version of the library is being built.
>
> Thanks,
>      Doug Brunner
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-- 
Philippe.

