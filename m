Message-ID: <476A4F33.2050107@domain.hid>
Date: Thu, 20 Dec 2007 12:17:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D8018CFEBF@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D8018CFEBF@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Uniqueness of registry objects
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas.Debes@domain.hid
Cc: xenomai@xenomai.org

Thomas.Debes@domain.hid wrote:
> Hi,
> 
> I am using the native skin together with mutexes and message queues. If
> I use the same name for both objects (mutex="test" , queuename="test") I
> can not register the second one because it fails with error -17 (file
> exists) in rt_queue_create. I assume that the registry service doesn't
> make a difference between the various RT object types. Can you confirm
> this behaviour?

Yes.

 If it is by design would it be better to differ between
> the various RT object types (mutex, queue, pipe etc.)?
>

This uniqueness was deliberately required so that we could implement
remote object registration in the future, for supporting distributed
systems. In such a case, it's better that peers do not have to know
about each other's exact nature. In this case, one would just want to
establish a link between peers based on a common protocol, regardless of
what actually implements each communication endpoint.

-- 
Philippe.


