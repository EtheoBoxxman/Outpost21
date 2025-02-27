import { Fragment } from 'inferno';
import { useBackend } from '../../backend';
import { Box, Button, LabeledList, Section } from '../../components';

export const pda_main_menu = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    owner,
    ownjob,
    idInserted,
    categories,
    // pai,
    notifying,
  } = data;

  return (
    <Fragment>
      <Box>
        <LabeledList>
          <LabeledList.Item label="Owner" color="average">
            {owner}, {ownjob}
          </LabeledList.Item>
          <LabeledList.Item label="ID">
            <Button icon="sync" content="Update PDA Info" disabled={!idInserted} onClick={() => act('UpdateInfo')} />
          </LabeledList.Item>
        </LabeledList>
      </Box>
      <Section level={2} title="Functions">
        <LabeledList>
          {categories.map((name) => {
            let apps = data.apps[name];

            if (!apps || !apps.length) {
              return null;
            } else {
              return (
                <LabeledList.Item label={name} key={name}>
                  {apps.map((app) => (
                    <Button
                      key={app.ref}
                      icon={app.ref in notifying ? app.notify_icon : app.icon}
                      iconSpin={app.ref in notifying}
                      color={app.ref in notifying ? 'red' : 'transparent'}
                      content={app.name}
                      onClick={() => act('StartProgram', { program: app.ref })}
                    />
                  ))}
                </LabeledList.Item>
              );
            }
          })}
        </LabeledList>
      </Section>
      {
        // !!pai && (
        //  <Section level={2} title="pAI">
        //    <Button fluid icon="cog" content="Configuration" onClick={() => act('pai', { option: 1 })} />
        //    <Button fluid icon="eject" content="Eject pAI" onClick={() => act('pai', { option: 2 })} />
        //  </Section>
        // )
      }
    </Fragment>
  );
};
