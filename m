Message-ID: <5542299B.30409@xenomai.org>
Date: Thu, 30 Apr 2015 15:09:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEceJGYZ+RQ4eW9vnvfM=iLNTUv7sN0ePij4aEbegdAM+w@mail.gmail.com>
 <5541FD72.3090806@xenomai.org>
 <CAMJ=MEcq-VE-QK021_RigRUVbbXOtKwL4G27bhtP=y+hX3eE6w@mail.gmail.com>
In-Reply-To: <CAMJ=MEcq-VE-QK021_RigRUVbbXOtKwL4G27bhtP=y+hX3eE6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] Task blocked in t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: "martin.bielik.sk" <martin.bielik.sk@gmail.com>, xenomai@xenomai.org

On 04/30/2015 02:39 PM, Ronny Meeus wrote:
> If I run the test I see:
> 
> /tmp # ./task_delete
> Start of test
> Create and start main task:Create task M:
> Create task L:
> Start task M:
> Start task L:
> M: entry
> L: entry
> M: Dead loop starts
> Cleaning ..
> End of test
> 
> Here is the piece of the code that goes wrong:
> 
>   printf("Cleaning ..\r\n");
>   /* Remove tasks */
>   t_delete(L_id);
>   /* Followed code is not executed because t_delete is somehow blocked */
>   printf("Removed L task id = 0x%lx\r\n", L_id);
>   t_delete(M_id);
>   printf("Removed M task id = 0x%lx\r\n", M_id);
> }
> 
> Since the trace "Removed L task id..." is not generated, my assumption
> it that the t_delete(L_id) blocks.
> 
> 

Could you attach GDB to the hung process, then dump a backtrace for all
the remaining threads?

-- 
Philippe.

