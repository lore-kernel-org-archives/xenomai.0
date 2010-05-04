Message-ID: <4BE0634E.8080005@domain.hid>
Date: Tue, 04 May 2010 20:11:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BDE8F79.5010905@domain.hid>
	<4BDF19ED.7060104@domain.hid>	<4BDFD008.9060106@domain.hid>
	<4BDFD704.7070902@domain.hid>
In-Reply-To: <4BDFD704.7070902@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] debian: sync with 2.5.2-2
	from	debian.org, 
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

Roland Stigge wrote:
> Hi,
> 
> On 05/04/2010 09:43 AM, Stefan Kisdaroczi wrote:
>>> Reading your patch, maybe libxenomai.so.0 should be called libxenomai.so.1 ?
>> The comment in the libxenomai1.lintian hunk was added by Roland, so it's probably
>> better to ask him. Roland, what do you think ?
> 
> The comment resulted from the discrepancy between the Debian package
> name "libxenomai1" and the SO version of libxenomai.so.0.
> 
> When there was no libxenomai.so, yet, I called the Debian package with
> all the *.so.* "libxenomai1" by convention. I won't rename it to
> "libxenomai0" because:
> 
> (1) I won't downgrade the "version" encoded in the package name
> (2) There are other SOs in the package which have their own SO versions,
> even though all or most of them also have "0".
> 
> I propose keeping number as they are for now. Everything is working fine
> currently.
> 
> I just propose to stick to correct library SO versioning. See also
> 
> http://www.netfort.gr.jp/~dancer/column/libpkg-guide/libpkg-guide.html
> 
> which is the Debian perspective on the issue but it gives a good
> practical introduction to the topic. When SO versions change in the
> correct way (e.g. major SO version increments on ABI changes), I will
> update the package version as well.

Yes, right, now that we made libxenomai a shared library, we can not
really consider it an internal library any more, we have to take care of
incrementing the version when we change the ABI, which we have not done
yet. My previous informationn on library versioning was this:
http://sources.redhat.com/autobook/autobook/autobook_91.html#SEC91

What I meant is that we could artificially increment the library ABI
version, so that we get in-line with the package name. Of course, we
pretend we broke the ABI whereas we did not really do it, but it looks
harmless (but is it really?).

-- 
					    Gilles.

