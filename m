Message-ID: <48BD0925.2060105@domain.hid>
Date: Tue, 02 Sep 2008 11:36:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C4E23B50.85C%samf48@domain.hid>
In-Reply-To: <C4E23B50.85C%samf48@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel compile issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Sam Ferguson wrote:
> Here it is:

This config file is broken. It contains CONFIG_XENOMAI but not
CONFIG_IPIPE. So:
- either you edited by hand (which does not seem to be the case
according to your earlier posts);
- or your kernel is not patched with the Adeos I-pipe patch.

Do not you get any error message when running the prepare-kernel.sh script ?

-- 
                                                 Gilles.


