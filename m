Message-ID: <50807ACD.4090506@nta-inc.net>
Date: Thu, 18 Oct 2012 16:55:25 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <507C82E0.2030409@nta-inc.net> <507C85BB.3090204@nta-inc.net>
In-Reply-To: <507C85BB.3090204@nta-inc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Building deb packages under Ubuntu 12.04
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 10/15/2012 04:52 PM, Jeff Webb wrote:
> On 10/15/2012 04:40 PM, Jeff Webb wrote:
>> In order to build a set of xenomai deb packages from the xenomai-2.6.git repo under ubuntu 12.04, I had to make the following change.  Otherwise, the build process aborts because it can't copy files into a non-existent directory.
>>
>> -Jeff
>>
>
> Sorry.  I think a should have given the patch inline:
>
> diff --git a/debian/rules b/debian/rules
> index d336511..634ecf5 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -96,6 +96,7 @@ install: build
>       $(MAKE) install DESTDIR=$(CURDIR)/debian/tmp/
>       dh_install --sourcedir=$(CURDIR)/debian/tmp
>       # Patch collection:
> +    mkdir -p $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
>       cp adeos-ipipe-*.patch $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
>       # xeno-config should be only in libxenomai-dev
>       rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config

Does this change make sense to anyone else?  If so, can it be added to the xenomai git repositories, so that it makes it into future releases?

-Jeff


