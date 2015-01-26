Message-ID: <54C6BF08.3020606@grinta.net>
Date: Mon, 26 Jan 2015 23:26:16 +0100
From: Daniele Nicolodi <daniele@grinta.net>
MIME-Version: 1.0
References: <129277905.Ag2XebZWbK@soho> <2155048.C7RTQC2ILE@indiana>
 <20150126182046.GL12812@hermes.click-hack.org> <2312262.WiWDxI5CGn@indiana>
In-Reply-To: <2312262.WiWDxI5CGn@indiana>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 26/01/15 23:17, Leopold Palomo-Avellaneda wrote:
> AFAIK, looking the sources of the package, the names of the libraries are 
> different. And installing in my box I have:
> 
> /usr/lib/x86_64-linux-gnu/libcurl-nss.so.4.3.0
> /usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.4.3.0
> /usr/lib/x86_64-linux-gnu/libcurl.so.4.3.0
> 
> that comes from libcurl3-nss, libcurl3-gnutls and libcurl3. The last one  
> (OpenSSL flavour)

The different library names are created in the debian package, not by
the upstream build system:
http://anonscm.debian.org/cgit/collab-maint/curl.git/tree/debian/rules

That is what Gilles wanted to point out: renaming the packaged library
is done by the packaging machinery to suite the distribution, not upstream.

> I agree. I would like to find something that could benefit all the parts. If you 
> prefer not rename, no problem. I though that it could be a good idea for all. 
> Also I have to say that I don't think that it has sense to implement it in 
> packaging. This kind of modifications have to have a very good reason to 
> diverge from upstream.

See above.

Cheers,
Daniele


