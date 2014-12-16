Message-ID: <549070E1.7010904@nta-inc.net>
Date: Tue, 16 Dec 2014 11:50:25 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <548ed95828a095.41388325@wp.pl>
In-Reply-To: <548ed95828a095.41388325@wp.pl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet compilation issues with kernel above 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 12/15/2014 06:51 AM, Mariusz Janiak wrote:
> Hi,
>
> I have prepared a patch that should fix the RTnet compilation issues on a kernel 3.10 and higher, especially the latest supported 3.14.17 by the Xenomai 2.6.4. It is based on the Anders Blomdell patch
>
> http://sourceforge.net/p/rtnet/mailman/message/32034653/
>
> supplemented with missing parts. Patch should be applied to original RTnet git repository.

Thank you very much for posting this patch.  I tried it out, and it works for me with Xenomai-2.6.4/Linux-3.14.17/rt_e1000e on x86-64.

-Jeff


