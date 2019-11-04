Subject: Re: binding to iddp socket often blocks forever
References: <DB8PR05MB5915DE0FD6015A0252EFEBE8F6610@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <DB8PR05MB5915CF27238C653EACF323AEF6610@DB8PR05MB5915.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <995694a2-6886-b425-9d5b-89834eabc50c@siemens.com>
Date: Mon, 4 Nov 2019 11:54:59 +0100
MIME-Version: 1.0
In-Reply-To: <DB8PR05MB5915CF27238C653EACF323AEF6610@DB8PR05MB5915.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 29.10.19 17:54, Lange Norbert via Xenomai wrote:
> Well, seems like my bootargs are related,
> I tried to bind linux to Core #0 and leve the remaining for Xenomai,
> Using "isolcpus=1-3 xenomai.supported_cpus=0x6"
> 
> I get this Warning when the deadlock happens:
> [  106.882123] [Xenomai] thread new_project[798] switched to non-rt CPU0, aborted.
> 
> I am not clear what happened, this is likely my non-rt thread suddenly running on the
> non-Xenomai CPU, I don't know how it happened.
> This is not the first Xenomai/cobalt function I am calling, I don't understand why its failing always at that point.
> 

Could you create an ftrace recording of the Xenomai events as well as
some Linux core scheduling events? I typically use this:

trace-cmd record -e "cobalt*" -e sched -e signal

Jan

>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Lange
>> Norbert via Xenomai
>> Sent: Dienstag, 29. Oktober 2019 17:32
>> To: Xenomai (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: binding to iddp socket often blocks forever
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> Hello,
>>
>> I have some problems with Xenomai 3.1rc2, the following function will often
>> block after printing "b".
>> This does not happen always and never happens when I run the program
>> through gdb, and I can't attach with gdb if its blocked.
>> Using another port then -1 makes no difference, and there is a single XDDP
>> connection active at the time (on port #0), but this should be the first and
>> only IDDP socket open.
>>
>> static int s_bindRtIpcEndpoint(int protocol, czstring pLabel, const int *pArgs,
>> int *pErrno) {
>>     int ret;
>>     int __attribute__((cleanup(auto_closesocket_rt))) fd =
>> __RT(socket)(AF_RTIPC, SOCK_DGRAM, protocol);
>>     TEST_LOG_ERRNO_ERROR_M_SCOPE(fd < 0, *pErrno, "socket", -1);
>>     printf("a\n");
>>     if (protocol == IPCPROTO_BUFP) {
>>         size_t bufsz = 32768; /* bytes */
>>         if (pArgs)
>>             bufsz = *pArgs;
>>         ret = setsockopt(fd, SOL_BUFP, BUFP_BUFSZ, &bufsz, sizeof(bufsz));
>>         TEST_LOG_ERRNO_ERROR_M_SCOPE(ret != 0, *pErrno, "setsockopt", -
>> 1);
>>     }
>>
>>     if (pLabel)
>>         setLabel(fd, protocol, pLabel);
>>
>>     printf("b\n");
>>     // bind first endpoint
>>     struct sockaddr_ipc saddr = {AF_RTIPC, -1};
>>
>>     ret = __RT(bind)(fd, (struct sockaddr *)&saddr, sizeof(saddr));
>>     printf("c\n");
>>     TEST_LOG_ERRNO_ERROR_M_SCOPE(ret != 0, *pErrno, "bind", -1);
>>     ret = fd;
>>     fd = -1; // NOLINT(clang-analyzer-deadcode.DeadStores)
>>     return ret;
>> }
>>
>> The function is called like this:
>>
>> int tmp;
>> s_bindRtIpcEndpoint(IPCPROTO_IDDP, NULL, NULL, &tmp);
>>
>> I really don't know how to tackle this, any hints?
>>
>> Mit besten Grüßen / Kind regards
>>
>> NORBERT LANGE
>>
>> AT-RD3
>>
>> ANDRITZ HYDRO GmbH
>> Eibesbrunnergasse 20
>> 1120 Vienna / AUSTRIA
>> p: +43 50805 56684
>> norbert.lange@andritz.com
>> andritz.com
>>
>> ________________________________
>>
>> This message and any attachments are solely for the use of the intended
>> recipients. They may contain privileged and/or confidential information or
>> other information protected from disclosure. If you are not an intended
>> recipient, you are hereby notified that you received this email in error and
>> that any review, dissemination, distribution or copying of this email and any
>> attachment is strictly prohibited. If you have received this email in error,
>> please contact the sender and delete the message and any attachment from
>> your system.
>>
>> ANDRITZ HYDRO GmbH
>>
>>
>> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
>>
>> Firmensitz/ Registered seat: Wien
>>
>> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>>
>> Firmenbuchnummer/ Company registration: FN 61833 g
>>
>> DVR: 0605077
>>
>> UID-Nr.: ATU14756806
>>
>>
>> Thank You
>> ________________________________
> 
> ________________________________
> 
> This message and any attachments are solely for the use of the intended recipients. They may contain privileged and/or confidential information or other information protected from disclosure. If you are not an intended recipient, you are hereby notified that you received this email in error and that any review, dissemination, distribution or copying of this email and any attachment is strictly prohibited. If you have received this email in error, please contact the sender and delete the message and any attachment from your system.
> 
> ANDRITZ HYDRO GmbH
> 
> 
> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
> 
> Firmensitz/ Registered seat: Wien
> 
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> 
> Firmenbuchnummer/ Company registration: FN 61833 g
> 
> DVR: 0605077
> 
> UID-Nr.: ATU14756806
> 
> 
> Thank You
> ________________________________
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

