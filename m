Message-ID: <4A02AEC3.70401@domain.hid>
Date: Thu, 07 May 2009 11:49:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF4D358DA8.8C7A5638-ONC12575AF.00332A73-C12575AF.003367B6@domain.hid>
In-Reply-To: <OF4D358DA8.8C7A5638-ONC12575AF.00332A73-C12575AF.003367B6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: xenomai@xenomai.org

henning.richter@domain.hid wrote:
> Beside I actually don't use xconfig because QT3 is not installed
> my application runs well in console mode and I am able to gather
> information from /proc/xenomai/stat etc.

In a previous mail you told us that you were running your application in
graphical mode. If you are running in console mode, you should see the
oops (though it may not be easy to capture, and you may need to actually
increase the console resolution through kernel command line to see the
message entirely, some people in the past send us numerical photos of
the screen to show us their oops...).

As for not being able to use switchtest, sorry, but if you do not want
to use the graphical tool, you have to learn how to search in text mode,
this means find . -name 'Kconfig*' | xargs grep switchtest...

-- 
                                                 Gilles.

