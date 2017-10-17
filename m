References: <1508232053.2272.23.camel@scrappix.utpvision.local>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <96045a73-a4c5-a441-ec74-31d03322b0d3@xenomai.org>
Date: Tue, 17 Oct 2017 12:04:02 +0200
MIME-Version: 1.0
In-Reply-To: <1508232053.2272.23.camel@scrappix.utpvision.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heap binding error (EWOULDBLOCK)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Finazzi <rfinaz@tin.it>, xenomai@xenomai.org

On 10/17/2017 11:20 AM, Roberto Finazzi wrote:
> Hi,
> I'm porting an old Xenomai 2.5.6 application to the Cobalt 3.0.5.
> In the original application there were several heaps shared between many
> processes.
> Now I maintained the same structure but, when I tryed to bind an already
> created heap from another process, I had always the EWOULDBLOCK error.
> The names used in create and bind were the same. In the previous
> application the heap was created using H_SHARED but now is obsolete.
> 
> Just to test I created two simple programs with a shared semaphore and
> the behaviour is the same: the second program is blocked always on the
> rt_sem_bind even if the semaphore is already created.
> It seems like if the name of the shared resource is not registered
> properly.
> 
> Have you got some suggestions for me?
> 

--enable-pshared is required for sharing common resources between processes.


-- 
Philippe.

