Subject: Re: Use of DESTDIR in xeno-config
References: <2015799461.12414544.1542356079122.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <29e3d91b-1fb5-d813-b800-7e6eee361519@siemens.com>
Date: Fri, 16 Nov 2018 14:29:21 +0100
MIME-Version: 1.0
In-Reply-To: <2015799461.12414544.1542356079122.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 16.11.18 09:14, Per Oberg via Xenomai wrote:
> Hi everyone
> 
> I'm confused over the xeno-config use of DESTDIR and cross-compiling. In the documentation (1) it is claimed that it follows the GNU coding standards.
> 
> Snippet:
> "If DESTDIR was set when installing Xenomai - typically after cross-compiling - DESTDIR must be set to the same value before calling xeno-config for accessing the target-based directories and files from the build system."
> 
> The example that is given handles install, and the GNU coding standards (2) also talks about installation. It even specifies: "DESTDIR should be supported only in the install* and uninstall* targets, as those are the only targets where it is useful."
> 
> However, xeno-config is hardly used during install.
> 
> My specific problem boils down to the following:
> I have built a toolchain for Yocto/Poky that has a xeno-config in the sysroot for the target machine. When using it together with autotools used in the etherlab ethercat master i need to set DESTDIR at configure time so that when xeno-config is called the paths to bootstrap.o and dynlib.ld. This feels wrong because of the above statements.
> 
> Can anyone enlighten me of the correct way of doing this?
> 

 From my reading of both the documentation and what you did, this seems 
consistent: You need to set DESTDIR when you access the toolchain - including 
xeno-config - from within the build system. Once you are on target system (or 
chroot into it), DESTDIR is out of the game.

The problem when looking at Yocto-like toolchains (SDKs) is that those might be 
relocated (moved around, installed to different directory) after being 
generated. In that case, DESTDIR may actually have to be updated accordingly as 
well. I already received the suggestion internally to derive the necessary base 
path in that case for the location of the compiler, which is doable but feels 
not really correct to me as well.

Jan

> (1) https://xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html
> (2) https://www.gnu.org/prep/standards/standards.html
> 
> TTFN
> Per Öberg
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

