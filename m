MIME-Version: 1.0
From: Jackson Jones <jackson.jones@gmail.com>
Date: Fri, 6 Oct 2017 18:56:54 -0700
Message-ID: <CADXNiGXxi3m+CK9BOGJaKdt4KzZ_KOFTdjXW3AT-cWM=YT4BHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rtdm_safe_copy_from_user() causing mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I noticed that when I call rtdm_safe_copy_from_user() it causes a mode
switch. I am looking to pass a uint32_t (u32 in kernel space) from
user-space to a rtdm driver.

Is there a way of doing this that avoids a mode switch. I am doing this in
an rtdm spi driver for the imx6. It is used to change the transfer size
(number of words) for the next call to transfer_iobufs (using the
SPI_RTIOC_TRANSFER ioctl).

Below is a modified spi_master_ioctl_rt which is inside of spi-master.c. I
added an ioctl to do this. I verified that the ioctls SPI_RTIOC_SET_CONFIG,
and SPI_RTIOC_GET_CONFIG cause a mode switch as well as the former calls
rtdm_safe_copy_from_user() and the latter calls rtdm_safe_copy_to_user().
Any advice would be appreciated.

147 static int spi_master_ioctl_rt(struct rtdm_fd *fd,
148                    unsigned int request, void *arg)
149 {
150     struct rtdm_spi_remote_slave *slave = fd_to_slave(fd);
151     struct rtdm_spi_master *master = slave->master;
152     struct rtdm_spi_config config;
153     u32 new_size = 0;
154     int ret;
155
156     switch (request) {
157     case SPI_RTIOC_SET_CONFIG:
158         ret = rtdm_safe_copy_from_user(fd, &config,
159                            arg, sizeof(config));
160         if (ret == 0)
161             ret = update_slave_config(slave, &config);
162         break;
163     case SPI_RTIOC_GET_CONFIG:
164         rtdm_mutex_lock(&master->bus_lock);
165         config = slave->config;
166         rtdm_mutex_unlock(&master->bus_lock);
167         ret = rtdm_safe_copy_to_user(fd, arg,
168                          &config, sizeof(config));
169         break;
170     case SPI_RTIOC_TRANSFER:
171         ret = -EINVAL;
172         if (master->ops->transfer_iobufs) {
173             rtdm_mutex_lock(&master->bus_lock);
174             ret = do_chip_select(slave);
175             if (ret == 0) {
176                 ret = master->ops->transfer_iobufs(slave);
177                 do_chip_deselect(slave);
178             }
179             rtdm_mutex_unlock(&master->bus_lock);
180         }
181         break;
182
183     // A hack to change the transfer size of the transfer buffers
184     case SPI_RTIOC_CHANGE_XFER_SIZE:
185         ret = rtdm_safe_copy_from_user(fd, &new_size,
186                            arg, sizeof(u32));
187         if (ret == 0)
188             master->ops->change_xfer_size(slave, new_size);
189         break;
190
191     default:
192         ret = -ENOSYS;
193     }
194
195     return ret;
196 }

Thanks,

Jackson Jones
