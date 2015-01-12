Date: Mon, 12 Jan 2015 11:45:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150112104559.GE25855@hermes.click-hack.org>
References: <2065498163.6212085.1421059225559.JavaMail.zimbra@enst.fr>
 <1238789666.6212719.1421059233270.JavaMail.zimbra@enst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1238789666.6212719.1421059233270.JavaMail.zimbra@enst.fr>
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

On Mon, Jan 12, 2015 at 11:40:33AM +0100, Adrien Canuel wrote:
> Hi,
> 
> I have successfully booted linux with Xenomai on the Zedboard from Xilinx, but when I try to launch the latency test, I get the error :
> "Xenomai/Cobalt: low_init(): binding failed: Function not implemented"
> I use the version 3.14.17 of the linux kernel. Can you help me with this ?

Either you do not boot a kernel patched with Xenomai, or Xenomai
initialization failed for some reason. So, in fact, you probably
have not successfully booted Linux with Xenomai. Please provide the
boot logs.

-- 
					    Gilles.

