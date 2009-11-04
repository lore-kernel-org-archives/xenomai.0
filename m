Message-ID: <4AF1591E.7080408@domain.hid>
Date: Wed, 04 Nov 2009 11:36:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580911040102r1dead1d3lbc66d9a4d9d26d33@domain.hid>
In-Reply-To: <1f3e02580911040102r1dead1d3lbc66d9a4d9d26d33@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [ARM_MV 88F6290] Task limit, msg receive error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Didenko Sergey wrote:
> Dear Experts

Hi, you do not need to flatter us to get answers :-)

> 
> we are facing 2 problems now:
> 
> 1) in our test application (very simple one) we can create maximum 50
> tasks, next task is failed to create with error *12*
> *- Is there any task number limit?*
> *- what does 12 mean?*

Please read the TROUBLESHOOTING guide which comes with Xenomai, for the
question about the task number limit.

For the error codes, see:
http://www.xenomai.org/index.php/Resolving_Error_Codes

> 
> 2) in our project (originally developed for VxWorks), msgQReceive
> function returns -1 and sets errno to 4
> *We think that it might be related to XNBREAK thread's flag.*

Yes, error 4 is EINTR, it means that msgQReceive was interrupted by a
signal. We can only tell you whether this is normal if you tell us in
exactly what conditions you get this error (a test case reduced to the
minimum would be welcome).

-- 
                                          Gilles


