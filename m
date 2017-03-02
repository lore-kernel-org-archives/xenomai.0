From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <ff158e3f-0693-6852-2ddd-4a6c82417d20@sigmatek.at>
Date: Thu, 2 Mar 2017 15:53:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rt_task_sleep returned -EPERM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>


I am calling function rt_task_sleep and the returncode is -EPERM
In the xenomai api I found that this is returned from a task that cannot 
sleep
see below
http://xenomai.org/documentation/xenomai-2.6/html/api/group__task.html#gad5225e5fb8d583fbdfa5299f322b8366

I can exclude that I am in an interrupt or a non-realtime because all my 
tasks are shadowed.
But how can I have a scheduler locked ?

Kind regards
Wolfgang


