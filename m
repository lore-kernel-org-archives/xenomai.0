Subject: Re: Re: Re: Antwort: Re: [Xenomai-help] pSOS skin questions
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1158760460.5094.40.camel@domain.hid>
References: <OFED2D8080.907D82EC-ONC12571EF.0047B742@domain.hid>
	<1158760460.5094.40.camel@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 15:58:57 +0200
Message-Id: <1158760738.5094.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Thomas Necker <Thomas.Necker@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-09-20 at 15:54 +0200, Philippe Gerum wrote:
> > What are the plans here: have a pSOS direct call interface, get rid of 
> > pSOS
> > support

No way. Xenomai is all about real-time interfaces, and providing
migration paths from traditional RTOS to Linux. Dropping pSOS would be
blatantly irrelevant with the project's goal.

-- 
Philippe.



