Date: Fri, 14 Oct 2016 11:45:37 +0200 (CEST)
From: pierre.roumagnac@free.fr
Message-ID: <231871933.347097737.1476438337896.JavaMail.root@zimbra19-e3.priv.proxad.net>
In-Reply-To: <1544623026.347009991.1476436922820.JavaMail.root@zimbra19-e3.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [xenomai]:heap memory management
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

I am currently working on a project running with xenomai 3.0.3 and using alchemy skin.
My context :
 - i need to use several large size queue using rt_queue_create (more than 1Mbytes each)
 - rt_queue_create does not work if i do not set --mem-pool-size option (we use 256M value) 

My problem:
 even if i generate a empty application:
int main(int argc,char**argv)
{
   return 0;
}
 my computer free memory drop of 256 MBytes at each application run which is really bothersome when debbuging.

Since i do not need shared memory, i have tried to used rt_heap_create / rt_heap_delete inside my application.
But with this solution i cannot create a heap more than 1MBytes which is not sufficient for my case.

My question is :
 is there a mean to release shared heap memory ? 
 or may be i do not correctly use rt_queue_create?

Thanks in advance for helps
Regards
PR


