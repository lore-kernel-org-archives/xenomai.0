Date: Mon, 25 Jan 2016 16:29:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160125152952.GB28849@hermes.click-hack.org>
References: <56A5761B.70501@grom.net>
 <CA+CJOCykM6VeHwyRtjwVC9H+RZw--=qTySzCv8bBXdJU1PHbpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CJOCykM6VeHwyRtjwVC9H+RZw--=qTySzCv8bBXdJU1PHbpQ@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai build for Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>
Cc: xenomai@xenomai.org

On Mon, Jan 25, 2016 at 04:16:04PM +0100, Nicolas SCHURANDO wrote:
> Hi Elmar,
> 
> The version of the linux kernel you should use is determined by the version
> of the i-pipe patch that is available for the hardware you are targeting.
> Here, as it is probably the case for most embedded boards, it turns out
> that the i-pipe patch alone is not enough.

To the contrary, most embedded boards supported by Xenomai are
supported by the mainline kernel and do not require further patches
than the I-pipe patch. See the list here:
https://xenomai.org/embedded-hardware/
Where the boards requiring additional patches are tagged with
"[separate-patch]".


-- 
					    Gilles.
https://click-hack.org

