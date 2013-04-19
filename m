Message-ID: <51713D3A.7050205@siemens.com>
Date: Fri, 19 Apr 2013 14:48:58 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <201304191346.38739.leo@alaxarxa.net>
In-Reply-To: <201304191346.38739.leo@alaxarxa.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Default options in the debian package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai <xenomai@xenomai.org>

On 2013-04-19 13:46, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> in the last days we have had a thread in the orocos-list [1] about the 
> convenience to have activated the option (enable-dlopen-skins) in xenomai to 
> use it with orocos properly.
> 
> I don't know exactly what does it means. The configure says:
> 
> --enable-dlopen-skins   Disable TLS features and automatic main thread
>                           mapping by the POSIX skin to allows dlopen'ing
>                           Xenomai libs. [default=no]
> 
> 
> I would like to know the implications of have activated this option by default 
> in the debian package (at least) . It could be possible? Implies to many 
> things?

Well, setting that feature extends the number of use cases for which the
debian package can be used as-is, namely loading skin libraries or other
libraries that require a skin lib via dlopen. We depend on this feature
here, thus carry a local patch against the debian rules, but so far I
thought that this is far from being a common requirement. Does Orocos
have a dynamic plugin concept?

The downside of make the feature default is a micro-performance
degradation (likely not an issue) and the lacking auto-shadowing of the
main thread when using POSIX skins. The latter is a behavioral change
that existing applications may depend and, thus, notice when updating to
the next Xenomai package version.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

