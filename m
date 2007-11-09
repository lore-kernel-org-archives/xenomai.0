MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18228.56759.327967.469205@domain.hid>
Date: Fri, 9 Nov 2007 23:22:47 +0100
In-Reply-To: <e4ef24880711091408p44b25f94i43ebb06d04e9c40f@domain.hid>
References: <e4ef24880711091329g3dd27f0ds6fe033ef79993022@domain.hid>
	<18228.55287.695219.531113@domain.hid>
	<e4ef24880711091408p44b25f94i43ebb06d04e9c40f@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Synchronizing CLOCK_REALTIME between networked
	computers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

Robert Gubler wrote:
 > I found it in the Xenomai POSIX skin API Reference Manual; dated: Sun Sep 16
 > 18:35:26 2007.  Perhaps doxygen didn't pick up the change for some reason..

I check trunk documentation on www.xenomai.org, at:
http://www.xenomai.org/documentation/trunk/pdf/posix-api.pdf
or
http://www.xenomai.org/documentation/trunk/html/api/
And clock_settime is correctly documented. And since this doc is
extracted nightly from xenomai svn, it means that the generated
documentation in the svn repository is also up to date.

Are you sure you are not checking the documentation of an older version,
like the v2.3.x branch ?

-- 


					    Gilles Chanteperdrix.

