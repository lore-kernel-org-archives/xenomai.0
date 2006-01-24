From: Stephan Zimmermann <s.zimmermann@domain.hid>
Subject: Re: [Xenomai-help] Meassage Queue c++
Date: Tue, 24 Jan 2006 17:42:16 +0100
References: <43CFC6B5.8080308@domain.hid>
	<200601200948.09127.s.zimmermann@domain.hid>
	<43D0AD9C.1030000@domain.hid>
In-Reply-To: <43D0AD9C.1030000@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601241742.16727.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,
after Jan looked over my code, it turned out to be a typical self-made ( RTFM 
somehow...) problem. My code did throw an exception when rt_queue_read() 
returned a positve value different from zero (which I naturally didn't 
catch :). This caused an effect that looked like a bigger Problem.

So, after all, it turned out that it is very well possible to use Xenomai in 
C++ Projects.

Thanks for the great support, Stephan

