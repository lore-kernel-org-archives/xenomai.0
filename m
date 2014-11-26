Date: Wed, 26 Nov 2014 17:09:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141126160936.GA6894@sisyphus.hd.free.fr>
References: <9BA84827B30CBE4996725F98F7DC9123428F6675@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC9123428F6675@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] ipipe-arm for kernel 3.12 on ls1021
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 26, 2014 at 03:09:04PM +0000, Hänel-Baas, Alexander wrote:
> What can I do to see why the kernel isn't starting and make the patch to work?

This is a port to a new platform, so you should read:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc

And for the answer to this particular question, read:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#Troubleshooting

Also, if you have the choice of the kernel, I would recommend to
stay away from the 3.12 kernel, the I-pipe branch you took has not
been validated as real I-pipe branches such as 3.14 or 3.10.

-- 
					    Gilles.

