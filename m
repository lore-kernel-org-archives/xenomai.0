References: <1560138.jJyhniltkJ@indiana>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c81239b6-2473-13c2-b04c-0cf64646f83c@xenomai.org>
Date: Tue, 20 Sep 2016 09:04:55 +0200
MIME-Version: 1.0
In-Reply-To: <1560138.jJyhniltkJ@indiana>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cannot create a share library linked against Xenomai
 libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Xenomai Users list <xenomai@xenomai.org>

On 09/19/2016 10:45 PM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> I'm trying to build a shared library, using the posix skin with Xenomai 3.0.3. 
> I have built xenomai with:
> 
> '--with-core=cobalt' '--enable-smp' '--enable-pshared' '--enable-fortify' 
> '--enable-shared
> 
> I built withour any error. However, when I try to build a library (shared) 
> that uses xenomai I got this error:
> 
> /usr/bin/ld: /usr/xenomai/lib/xenomai/bootstrap.o: relocation R_X86_64_32 
> against `.rodata.str1.1' can not be used when making a shared object; 
> recompile with -fPIC
> 
> Static libs build perfect. 
> 
> Any idea,
> 
> Best regards,
> 
> Leopold
> 
> 

You may want to check --auto-init-solib from xeno-config:

http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html

-- 
Philippe.

