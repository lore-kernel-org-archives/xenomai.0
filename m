References: <b3a6f4c97449444a9f315329b4b7faf1@AM3PR48MB0130.041d.mgd.msft.net>
From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <1d69d480-52da-5a17-2ca9-d9b5ce296501@mperpetuo.com>
Date: Wed, 31 Aug 2016 11:29:39 -0700
MIME-Version: 1.0
In-Reply-To: <b3a6f4c97449444a9f315329b4b7faf1@AM3PR48MB0130.041d.mgd.msft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [ARM64] Context saving problem with floating point
 registers?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


> Do you see any problem in my configuration, or is it a bug? Please, do
> not hesitate to ask me more information if needed. I am trying to
> understand the problem, but with no success for now.

I can confirm that this is a bug. The fpsimd switch mechanism on the 
Xenomai side does not work correctly with newer kernels. Further, disabling 
lazy switching won't help either, as ipipe is not aware of the optimized 
switching algorithm used by this kernel.

-Dmitriy


