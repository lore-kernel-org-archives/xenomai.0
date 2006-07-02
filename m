From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17575.59696.704995.171840@domain.hid>
Date: Sun, 2 Jul 2006 17:41:36 +0200
Subject: Re: [Xenomai-help] upgrading versions of xenomai 2.2
In-Reply-To: <02AA386EB831044F8537A696BA785C78A66771@domain.hid>
References: <02AA386EB831044F8537A696BA785C78A66771@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

Landau, Bracha wrote:
 > I have encountered trouble upgrading from xenomai-2.2 rc2 to xenomai 2.2 rc3.
 > If the "prepare-script" file encounters a kernel which already has the "xenomai" directories included (from a previous version of xenomai), the "prepare-kernel" script will not do anything.
 > 
 > In order to bypass this problem I had to search for all the "xenomai" subdirectories in the linux tree and rename them. (I searched for the "patch_link" commands inside "prepare-kernel" in order to know what had to be re-patched.)
 > 
 > Is there a way you can indicate that you want to upgrade your kernel?

This problem is due to my usage scenario of the prepare-kernel.sh
script. Maybe we can try to come to a better solution. In the mean-time,
you can use the --forcelink switch.

-- 


					    Gilles Chanteperdrix.

