References: <b3a6f4c97449444a9f315329b4b7faf1@AM3PR48MB0130.041d.mgd.msft.net>
 <1d69d480-52da-5a17-2ca9-d9b5ce296501@mperpetuo.com>
 <8d544c56950547518f0e6aa5908ddf0a@AM3PR48MB0130.041d.mgd.msft.net>
From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <115943e8-eaf2-66f2-800f-bee51b5f9375@mperpetuo.com>
Date: Thu, 1 Sep 2016 09:24:54 -0700
MIME-Version: 1.0
In-Reply-To: <8d544c56950547518f0e6aa5908ddf0a@AM3PR48MB0130.041d.mgd.msft.net>
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


> Do you know if there is a workaround? Maybe a previous version of
> ipipe/linux (where to find it ?)?

For now I think the most stable fpsimd support is in the 3.18 kernel, which 
can be found in Jorge's hikey port here:

http://git.xenomai.org/ipipe-jro.git/

And here is the Xenomai side to go with it, also in the hikey branch:

http://git.xenomai.org/xenomai-jro.git/

-Dmitriy

