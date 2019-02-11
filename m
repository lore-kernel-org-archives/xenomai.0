Subject: Re: RTCan missing frames
References: <aea6afe6-99e3-9e60-6004-05d7a3d0eb42@compador.de>
 <5f653b5a-e82f-ce42-c8c6-3fa05ccce53d@grandegger.com>
 <f6a62138-a1fa-f631-25b4-5acb1037273d@compador.de>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <063773f9-ac33-fb9c-7cf4-7c971f882041@grandegger.com>
Date: Mon, 11 Feb 2019 13:40:38 +0100
MIME-Version: 1.0
In-Reply-To: <f6a62138-a1fa-f631-25b4-5acb1037273d@compador.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

Hello,

Am 11.02.19 um 12:55 schrieb Johannes Holtz:
> Am 11.02.19 um 12:26 schrieb Wolfgang Grandegger:
>> Hello,
>>
>> Am 11.02.19 um 10:16 schrieb Johannes Holtz via Xenomai:
>>> Hi,
>>>
>>> In my application i set up a RTCAN socket and a pair of rt-threads. One
>>> to read and one to write. Writing works perfectly and I receive answers
>>> in the initial phase of the program.
>>>
>>> In particular I send CANopen NMT messages out and receive the responses
>>> from the other Nodes in the Network.
>>>
>>> 2019-02-11 09:52:13.309[       500][    CAN TX] > NMT Node 0:0:
>>> CAN ID 0x000 FC 0x0 DLC 2
>>>          0       82 00
>>> 2019-02-11 09:52:13.310[       503][    CAN RX] > NMT Error Control Node
>>> 0:8:
>>> CAN ID 0x708 FC 0xe DLC 1
>>>          0       00
>>> 2019-02-11 09:52:13.311[       503][    CAN RX] > NMT Error Control Node
>>> 0:9:
>>> CAN ID 0x709 FC 0xe DLC 1
>>>          0       00
>>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node
>>> 0:3:
>>> CAN ID 0x703 FC 0xe DLC 1
>>>          0       00
>>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node
>>> 0:4:
>>> CAN ID 0x704 FC 0xe DLC 1
>>>          0       00
>>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node
>>> 0:5:
>>> CAN ID 0x705 FC 0xe DLC 7
>>>          0       00 06 07 00
>>>          4       00 01 01
>>> 2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Node 0:0:
>>> CAN ID 0x000 FC 0x0 DLC 3
>>>          0       07 00 00
>>> 2019-02-11 09:52:13.326[       519][    CAN RX] > TIME Node 0:1:
>>> CAN ID 0x101 FC 0x2 DLC 0
>>>
>>> As you can see, I capture 7 frames. However, the RX count from
>>> /proc/rtcan/devices is 10.
>>>
>>> If I send specific SDO requests to one of the node which have answered I
>>> don't capture a response but the RX count increases and rtcanrecv
>>> program captures the correct response. Only my application's read
>>> doesn't return.
>> Then there seem to be a problem with the read in you application. Can
>> you show use the related code?
>>
>> Wolfgang.
> 
> Here is the main function of the rx thread. This will be executed every
> 1ms.
> 
> void can_rx_run(rt_thread_data_t *rt_data) {
>     can_thread_data_t *data = (can_thread_data_t *) rt_data->data;
>     data->time++;
>     static can_frame_t frame_buffer[RX_BUF_SZ];
>     static can_frame_t *frame   = NULL;
>     static can_bus_t *bus       = NULL;
>     int bytes = 1, ret, buf_i = 0;
>     uint32_t bus_idx = 0;
>     if ((data->time > 10)&& (data->time%2)) {
>         bytes       = 1;
>         for (bus_idx = 0; bus_idx < data->n_buses; bus_idx++) {
>             bus     = &data->buses[bus_idx];
>             if(!bus->ready) continue;
>             while (bytes > 0 && (buf_i<2)) {
>                 frame   = &frame_buffer[buf_i];
>                 memset(frame, 0, sizeof (*frame));
>                 bytes   = rt_dev_recv(bus->socket, frame, sizeof
> (*frame), MSG_DONTWAIT);
>                 if (bytes < 0) {
>                     if ((bytes != -ETIMEDOUT) && (bytes != -EAGAIN)) {
>                         rtlog(data->log, data->time, LOG_TAG_ERROR,
> "Connection ended unexpected ret %d errno %d", bytes);
>                     }else{
>                         bytes = 1;
>                     }
>                     break;
>                 } else if (bytes == 0) {
>                     rtlog(data->log, data->time, LOG_TAG_ERROR, "CAN Bus
> Connection closed by peer");
>                     break;
>                 }
>                 // move pointer forward for the next frame
>                 buf_i = (buf_i + 1) % RX_BUF_SZ;
> 
>                 log_frame(data->log, data->time, frame, bus_idx);
>                 ret = check_frame_integrity(data->log, data->time, frame);
>                 if (ret) {
>                     rtlog(data->log, data->time, LOG_TAG_ERROR,
>                           "Frame didn't pass integrity check %d", ret);
>                     continue;
>                 }
>                 ret = process_frame(data->ipc_socket, frame, bus_idx);
>                 if (ret < 0) {
>                     rtlog(data->log, data->time, LOG_TAG_ERROR,
>                           "failed to accept RX CAN frame %d from Node %u",
>                           ret);
>                 }
>             }
>         }
>     }
> }

And the code setting up the socket?

Wolfgang.

