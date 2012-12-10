Message-ID: <50C646F2.9040904@xenomai.org>
Date: Mon, 10 Dec 2012 21:32:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: "\"\\\"\\\\\\\"\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"<50B8B7A8.2010800@xenomai.org>\\\"	\"\\\\\\\"<D5733E9B-1AA5-4C5F-A2E8-1346A11A7E4C@mah.priv.at>\\\\\\\\\\\\\\\"\\\\\\\"\\\"\"	\"<7563882586f5c36943667b067978e7ff@isir.upmc.fr>\\\"	<50BB69A4.8020401@xenomai.org>	\"<f4d725b0ea36a139107d61f00b627b47@isir.upmc.fr>\\\"\"
	<50BB7E6D.8080602@xenomai.org>"
	<54b68e5271dffe6add316e94480ffeb6@isir.upmc.fr>
	<5f186a473469646525a404ab3fbe4a62@isir.upmc.fr>
	<50BD043D.8080901@xenomai.org>
	<798d18aaa8af5d21590a2c2dacc2d400@isir.upmc.fr>
	<274ee8164e9384b2faf0dbe50bf890be@isir.upmc.fr>
	<50BE4F09.7060508@xenomai.org>
	<4f87d2b280543885c9cefc9b9d376fa9@isir.upmc.fr>
	<50C63303.407@xenomai.org>
	<ebaafe297f9d50512d32831f8757cb3b@isir.upmc.fr>
In-Reply-To: <ebaafe297f9d50512d32831f8757cb3b@isir.upmc.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: WONG Sheng Chao <wong@isir.upmc.fr>
Cc: xenomai@xenomai.org

On 12/10/2012 09:23 PM, WONG Sheng Chao wrote:

> I'm sorry but can you be more specific about the error i made as i am 
> still new to source control. What do you mean by putting xenomai in the 
> sources? What i did was
> 
> 1) Pre patch the vendor source to remove the conflict files for ipipe 
> patch
> 
> 2) Patch the updated vendor source with ipipe using prepare-kernel.sh ( 
> Is this a mistake? )


Yes. And the pre and post patch can be generated from a working tree,
they are not what you should put under version control.

> 
> 3) post patch the ipipe patched source
> 
> 4) Compile and deploy the kernel


You should run prepare-kernel.sh at this point, using the I-pipe patched
kernel, and keep the I-pipe patched kernel and xenomai sources separate,
so that you can update them separately.

-- 
                                                                Gilles.

