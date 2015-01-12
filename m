Date: Mon, 12 Jan 2015 17:28:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150112162824.GB9452@hermes.click-hack.org>
References: <2065498163.6212085.1421059225559.JavaMail.zimbra@enst.fr>
 <1238789666.6212719.1421059233270.JavaMail.zimbra@enst.fr>
 <20150112104559.GE25855@hermes.click-hack.org>
 <172953270.6511559.1421074595415.JavaMail.zimbra@enst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172953270.6511559.1421074595415.JavaMail.zimbra@enst.fr>
Subject: Re: [Xenomai] Latency test on Zedboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Adrien Canuel <adrien.canuel@telecom-paristech.fr>
Cc: xenomai@xenomai.org

On Mon, Jan 12, 2015 at 03:56:35PM +0100, Adrien Canuel wrote:
> I had to reconfigure the kernel because for some reason Xenomai wasn't working any more.
> Before the kernel was configured to work with only one processor (because one processor was always blocked during the boot phase), and I got the binding error when I tried to launch the latency test.
> Now I configure the kernel to work with multiple processor (this time the boot completed without problem), and the latency test runs well.
> I just had to add some links in the /dev repertory, because the application needed the /dev/rtdm/memdev-private and /dev/rtdm/memdev-shared devices, and I have these two devices directly under the /dev directory (not /dev/rtdm).

Listen, if you need some help, then please provide some details
about the problem you have, because what you write above is
not understandable. See:

https://xenomai.org/asking-for-help/

Something I understand is that you are using the patch for Zynq,
which is an add-on not part of the platforms supported by the I-pipe
kernel Xenomai, so maybe yes, the patch for Zynq does not work
without CONFIG_SMP (if this is even what your gibberish is talking
about). 

Please no top posting.

-- 
					    Gilles.

