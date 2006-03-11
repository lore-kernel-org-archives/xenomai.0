From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Planetplanet on the web site?
Date: Sat, 11 Mar 2006 14:28:02 +0900
References: <200603102000.02421.rlenglet@domain.hid>
	<f48df4840603100819v50aa6c75kdb13421ab5a7792@domain.hid>
In-Reply-To: <f48df4840603100819v50aa6c75kdb13421ab5a7792@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603111428.03185.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: xenomai@xenomai.org

> For your information Xenomai website currently uses Joomla CMS framework.
> The website is currently hosted by the fsffrance whose sys admin is really
> careful about security issues. This means that we are advised to use debian
> stable packages only. I don't know if such a package exists for Planet (I
> don't find it via debian search engine.)

No there is none yet.
To install it on Sarge, you must install packages python-feedparser and 
python.
Then, download the tarball from planetplanet's website, configure the 
templates, and make the python script run through cron. It generates static 
HTML pages, and is not a dynamic script, so there are little security risks, 
except that it must download the news feed files from the Internet to 
generate the pages.

> I need to check first if it is not possible to register news feeds directly
> with Joomla. Maybe it offers this functionality as a module. I'm quite sure
> though I am going to stick to joomla because I noticed that some browsers
> (Konqueror for example) have problems displaying the website correctly !

I am using Konqueror 3.5.1, and I have no problem?!

--
Romain Lenglet

