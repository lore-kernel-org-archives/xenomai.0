References: <CALC3Xwp-pSsQ+hF6bZFyT7BCrTOE2o0G4A3_hgD7o4i=9hdO7Q@mail.gmail.com>
 <8ddcffac-78ab-3933-f5bf-1352f1af6a1d@xenomai.org>
 <CALC3Xwp0soSABRS12_3V8OEfNY_18eR5mB_qZqR9MTsdfq5WMA@mail.gmail.com>
 <CALC3XwoXJ2f6btgkOt2nJ4z1KGf=bB4g=0bE6w7jZfQD42jkRA@mail.gmail.com>
 <CALC3XwoytMPBagjtb8eHd7HxVmbqPE4ck1woX8sWNwR_rXfz5A@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <da41a276-60bc-7672-947d-2aa931c79606@xenomai.org>
Date: Mon, 15 May 2017 10:53:57 +0200
MIME-Version: 1.0
In-Reply-To: <CALC3XwoytMPBagjtb8eHd7HxVmbqPE4ck1woX8sWNwR_rXfz5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Fwd: Problem with the priority of the task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Aur=c3=a9lien_Le_Floc'h?= <le.floch.aurelien94@gmail.com>, xenomai@xenomai.org

On 05/15/2017 10:22 AM, Aurélien Le Floc'h wrote:
> Hello everyone,
> 
> I have another problem with the task priority. The following program
> produce this trace and it's not correct with the priority. However all the
> rt_task_create (which switch to secondary mode) is used before the start.
> So I don't understand why it's doesn't working...
> 

Please collect the test results in memory first, then output the
contents of this memory at the end of such test. Using inline printouts
is unreliable.

-- 
Philippe.

