From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Sat, 18 Dec 2010 11:17:46 +0100
References: <AANLkTikm-ERjxUBYZ1d7r06rmfdsZWPyibdVRVVKPNU+@mail.gmail.com>
In-Reply-To: <AANLkTikm-ERjxUBYZ1d7r06rmfdsZWPyibdVRVVKPNU+@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201012181117.46352.kisda@domain.hid>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] non-root user access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am Freitag 17 Dezember 2010, 09:48:18 schrieb Gajamohan Mohanarajah:
> Hi,
> 
> I am running xenomai-2.5.5.2 with Ubuntu 10.04.
> Is there a way to allow a non-root user access.
> Now I get : [Xenomai: binding failed: Operation not permitted.]

Hi,

http://xenomai.org/index.php/Non-root_RT

If you have installed xenomai as a debian package, just add the user 
to the group xenomai:
  adduser gajan xenomai

http://xenomai.org/index.php/Building_Debian_packages

Stefan

