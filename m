References: <freemail.20180524105020.92819.1@fmxmldata01.freemail.hu>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3a3b124b-b029-a8e2-f4c3-4cdce3ec16c4@siemens.com>
Date: Thu, 24 May 2018 12:19:10 +0200
MIME-Version: 1.0
In-Reply-To: <freemail.20180524105020.92819.1@fmxmldata01.freemail.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Posix named semaphore used by two separate
	applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paal Tamas <paal_to@freemail.hu>, xenomai@xenomai.org

On 2018-05-24 10:50, Paal Tamas wrote:
> I would like to use the same named semaphore in two separate Xenomai binaries. I am using the Posix skin. It does not work as I am expecting it. 
> The first instance of my test application creates a named semaphore. It goes to sleep after that. The second instance of the same applications starts than. It realizes that the semaphore with the name already exists, so it opens it. The sem_open() returns a valid (like) pointer. After that all semaphore functions in this second application return EINVAL (22) (Invalid argument). Both the sem_wait() and the sem_close() function behave this way.
> 
> The same procedure worked fine in 2.6.2.1 (the previous version I used). I tried 3.0.5 and the latest git repository too. The same bad behavior there.
> 

Did you configure userspace with --enable-pshared?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

