References: <11512456.mgiilWixD3@wirbelwind>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56798160.9000600@xenomai.org>
Date: Tue, 22 Dec 2015 17:59:12 +0100
MIME-Version: 1.0
In-Reply-To: <11512456.mgiilWixD3@wirbelwind>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] userspace absolute timer value
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: steven.seeger@nasa.gov, xenomai@xenomai.org

On 12/15/2015 02:19 AM, Steven Seeger wrote:
> Since my last post I seem to have solved the issues with my ppc44x board hard 
> locking up. I've relayed this info to Philippe and hopefully he will confirm 
> that I'm correct and that I should make a patch.

Confirmed, the bug is real and ugly, the fix is nice and right. Please
send a patch over.

Thanks,

-- 
Philippe.

