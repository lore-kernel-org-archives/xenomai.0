Subject: Re: [ANNOUNCE] Xenomai 3.0.10 released
References: <8wpv79_me5liHbd4OzRAJqQ8h4itwxhL_-mICsJBiz8eH85PjroDi8SB8aBHhfZTyNugCjhXRkO-IwZ3OCnOdUEGfFMtQNqbZNjGSbWGdpQ=@protonmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <19bbd92b-9d19-eff5-8b66-30e7825b9220@siemens.com>
Date: Tue, 10 Dec 2019 17:29:22 +0100
MIME-Version: 1.0
In-Reply-To: <8wpv79_me5liHbd4OzRAJqQ8h4itwxhL_-mICsJBiz8eH85PjroDi8SB8aBHhfZTyNugCjhXRkO-IwZ3OCnOdUEGfFMtQNqbZNjGSbWGdpQ=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@protonmail.com>, Xenomai <xenomai@xenomai.org>

On 10.12.19 17:23, Jeff Webb via Xenomai wrote:
> I had an issue when trying to configure a kernel patched using 3.0.10.  My process was similar to the process I used when testing other releases.  Here is what I did:
> 
> Download xenomai-v3.0.10.tar.bz2 from "Download" button here:
> 
>    https://gitlab.denx.de/Xenomai/xenomai/-/tags
> 
> tar -xvf xenomai-v3.0.10.tar.bz2
> cd xenomai-v3.0.10/
> DEBEMAIL="your@email" DEBFULLNAME="Your Name" debchange -v 3.0.10 Release 3.0.10
> debuild -uc -us
> cd ..
> sudo dpkg -i libxenomai-dev_3.0.10_amd64.deb \
>    xenomai-kernel-source_3.0.10_all.deb \
>    libxenomai1_3.0.10_amd64.deb  \
>    xenomai-runtime_3.0.10_amd64.deb
> 
> tar -xvf linux-4.19.84.tar.xz

I should have left the note from the 3.0.9 release in this one:

"Note again that the 3.0.x series works up to kernel 4.14. For 4.19
support, please switch to master, the source of upcoming 3.1."

Well, there are RCs for 3.1 by now :)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

